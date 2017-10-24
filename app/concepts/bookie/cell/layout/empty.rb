require_dependency 'bookie/cell/layout'

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

        def body_classes
          %w(empty)
        end
      end
    end
  end
end
