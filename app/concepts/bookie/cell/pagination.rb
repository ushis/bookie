module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell

      def show
        super if show?
      end

      private

      def scope
        model
      end

      def show?
        scope.total_pages > 1
      end

      def params
        options.fetch(:params, {})
      end

      def link_to_prev_page
        concept('bookie/cell/pagination/prev', nil, {
          page: scope.prev_page,
          params: params,
          disabled: scope.first_page?,
        })
      end

      def link_to_next_page
        concept('bookie/cell/pagination/next', nil, {
          page: scope.next_page,
          params: params,
          disabled: scope.last_page?,
        })
      end
    end
  end
end
