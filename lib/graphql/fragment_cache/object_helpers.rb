# frozen_string_literal: true

require "graphql/fragment_cache/fragment"

module GraphQL
  module FragmentCache
    using Ext

    # Adds #cache_fragment method
    module ObjectHelpers
      extend Forwardable

      def self.included(base)
        return if base.method_defined?(:raw_value)

        base.include(Module.new {
          def raw_value(obj)
            GraphQL::Execution::Interpreter::RawValue.new(obj)
          end
        })
      end

      NO_OBJECT = Object.new

      def cache_fragment(object_to_cache = NO_OBJECT, **options, &block)
        raise ArgumentError, "Block or argument must be provided" unless block_given? || object_to_cache != NO_OBJECT

        options[:object] = object_to_cache if object_to_cache != NO_OBJECT

        context_to_use = options.delete(:context)
        context_to_use = context if context_to_use.nil? && respond_to?(:context)
        raise ArgumentError, "cannot find context, please pass it explicitly" unless context_to_use

        fragment = Fragment.new(context_to_use, **options)

        keep_in_context = options.delete(:keep_in_context)

        cached = GraphQL::FragmentCache::instrument("cache_fragment.read") do |payload|
          payload[:cache_key] = fragment.cache_key
          payload[:result] = fragment.read(keep_in_context)
        end

        if (cached)
          if cached == Fragment::NIL_IN_CACHE
            return GraphQL::FragmentCache::instrument("cache_fragment.cache_hit_nil_value") { nil }
          else
            return GraphQL::FragmentCache::instrument("cache_fragment.cache_hit_has_value") { |payload| payload[:result] = raw_value(cached) }
          end
        end

        GraphQL::FragmentCache::instrument("cache_fragment.cache_miss_resolve") do |payload|
          payload[:result] = (block_given? ? block.call : object_to_cache).tap do |resolved_value|
            payload[:resolved_value] = resolved_value
            context_to_use.fragments << fragment
          end
        end
      end
    end
  end
end
