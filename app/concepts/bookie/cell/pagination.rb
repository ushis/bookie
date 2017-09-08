module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell

      private

      def scope
        model
      end

      def link_to_prev_page
        concept('bookie/cell/pagination/prev', nil, {
          page: scope.prev_page,
          disabled: scope.first_page?,
        })
      end

      def link_to_next_page
        concept('bookie/cell/pagination/next', nil, {
          page: scope.next_page,
          disabled: scope.last_page?,
        })
      end
    end
  end
end
