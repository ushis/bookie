module Bookie
  class Cell < Trailblazer::Cell
    class Layout < Cell
      class Empty < Layout

        def show(&block)
          render(:layout, &block)
        end

        private

        def show_navigation?
          false
        end
      end
    end
  end
end
