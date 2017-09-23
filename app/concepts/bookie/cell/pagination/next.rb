module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell
      class Next < Link

        private

        def text
          'Next Page'
        end

        def classes
          %w(pagination-next)
        end
      end
    end
  end
end
