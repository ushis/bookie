module Bookie
  class Search
    module ActiveRecord
      class Request

        def initialize(scope, query)
          @scope = scope
          @query = query
        end

        def method_missing(method_name, *arguments, &block)
          if _query.respond_to?(method_name)
            _query.send(method_name, *arguments, &block)
          elsif _scope.respond_to?(method_name)
            _scope.send(method_name, *arguments, &block)
          else
            super
          end
        end

        def respond_to_missing?(method_name, include_all=false)
          _query.respond_to?(method_name) ||
            _scope.respond_to?(method_name) ||
            super
        end

        private

        def _query
          @query
        end

        def _scope
          @scope.where(id: ids).limit(_query.per).order_as_specified(id: ids)
        end
      end
    end
  end
end
