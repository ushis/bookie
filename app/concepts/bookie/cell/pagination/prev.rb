module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell
      class Prev < Link

        private

        def text
          'Previous'
        end
      end
    end
  end
end
