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

      def async_cache_fragment(object_to_cache = NO_OBJECT, **options, &block)
        context_to_use = options.delete(:context)
        context_to_use = context if context_to_use.nil? && respond_to?(:context)
        raise ArgumentError, "cannot find context, please pass it explicitly" unless context_to_use

        LazyResult.new(object_to_cache, context_to_use, **options, &block)
      end

      def cache_fragment(object_to_cache = NO_OBJECT, **options, &block)
        # async_cache_fragment(object_to_cache, **options, &block).sync
        raise ArgumentError, "Block or argument must be provided" unless block_given? || object_to_cache != NO_OBJECT

        options[:object] = object_to_cache if object_to_cache != NO_OBJECT

        context_to_use = options.delete(:context)
        context_to_use = context if context_to_use.nil? && respond_to?(:context)
        raise ArgumentError, "cannot find context, please pass it explicitly" unless context_to_use

        fragment = Fragment.new(context_to_use, **options)

        keep_in_context = options.delete(:keep_in_context)
        if (cached = fragment.read(keep_in_context))
          return cached == Fragment::NIL_IN_CACHE ? nil : raw_value(cached)
        end

        (block_given? ? block.call : object_to_cache).tap do |resolved_value|
          context_to_use.fragments << fragment
        end
      end
    end
  end
end
