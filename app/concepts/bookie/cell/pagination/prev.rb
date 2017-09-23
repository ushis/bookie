module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell
      class Prev < Link

        private

        def text
          'Previous Page'
        end

        def classes
          %w(pagination-previous)
        end
      end
    end
  end
end
