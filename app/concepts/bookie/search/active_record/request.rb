module Bookie
  class Search
    module ActiveRecord
      class Request
        delegate_missing_to :_scope

        def initialize(scope, query)
          @scope = scope
          @query = query
        end

        private

        def _scope
          @scope
            .where(id: @query.ids)
            .limit(@query.per)
            .order_as_specified(id: @query.ids)
            .extending(_scope_extension(@query))
        end

        def _scope_extension(query)
          Module.new do
            [
              :total_count,
              :total_pages,
              :current_page,
              :next_page,
              :prev_page,
              :first_page?,
              :last_page?,
              :out_of_range?,
            ].each { |method| define_method(method) { query.send(method) } }
          end
        end
      end
    end
  end
end
