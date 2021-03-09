
require "graphql/fragment_cache/fragment"
module GraphQL
  module FragmentCache
    class LazyResult
      class << self
        attr_accessor :results
        attr_accessor :keys
      end

      self.results = {}
      self.keys = []

      def initialize(object_to_cache, context_to_use, **options, &block)
        raise ArgumentError, "Block or argument must be provided" unless block_given? || object_to_cache != GraphQL::FragmentCache::ObjectHelpers::NO_OBJECT

        options[:object] = object_to_cache if object_to_cache != GraphQL::FragmentCache::ObjectHelpers::NO_OBJECT

        @object_to_cache = object_to_cache
        @context_to_use = context_to_use
        @options = options
        @block = block

        @fragment = Fragment.new(@context_to_use, **@options)
        self.class.keys << @fragment.cache_key
      end

      def sync
        keys = self.class.keys.uniq - self.class.results.keys
        unless keys.empty?
          self.class.results.merge!(FragmentCache.cache_store.read_multi(*keys))
        end

        keep_in_context = @options.delete(:keep_in_context)
        # FIXME: keep_in_context is no longer used here
        if (cached = self.class.results[@fragment.cache_key])
          return cached == Fragment::NIL_IN_CACHE ? nil : GraphQL::Execution::Interpreter::RawValue.new(cached)
        end

        (@block&.call || @object_to_cache).tap do |resolved_value|
          @context_to_use.fragments << @fragment
        end
      end
    end
  end
end
