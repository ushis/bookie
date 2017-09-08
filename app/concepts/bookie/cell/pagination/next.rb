module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell
      class Next < Link

        private

        def text
          'Next'
        end
      end
    end
  end
end
