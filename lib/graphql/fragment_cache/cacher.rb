# frozen_string_literal: true

module GraphQL
  module FragmentCache
    using Ext

    # Saves resolved fragment values to cache store
    module Cacher
      class << self
        def call(query)
          return unless query.context.fragments?

          if FragmentCache.cache_store.respond_to?(:write_multi)
            batched_persist(query)
          else
            persist(query)
          end
        end

        private

        def batched_persist(query)
          FragmentCache.instrument("fragment_cacher.batched_persist_count", count: query.context.fragments, any_nil: query.context.fragments.any?(value: nil))
          query.context.fragments.group_by(&:options).each do |options, group|
            hash = group.map { |fragment| [fragment.cache_key, fragment.value] }.to_h
            FragmentCache.instrument("fragment_cacher.batched_persist_write") do |payload|
              payload[:hash] = hash
              payload[:result] = FragmentCache.cache_store.write_multi(hash, **options)
            end
          end
        end

        def persist(query)
          query.context.fragments.each do |fragment|
            FragmentCache.instrument("fragment_cacher.persist_write") do |payload|
              payload[:cache_key] = fragment.cache_key
              payload[:value] = fragment.value
              payload[:options] = fragment.options
              payload[:result] = FragmentCache.cache_store.write(fragment.cache_key, fragment.value, **fragment.options)
            end
          end
        end
      end
    end
  end
end
