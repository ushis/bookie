require_dependency 'bookie/cell'

module Bookie
  class Cell < Trailblazer::Cell
    class Navigation < Cell

      def show
        render 'navigation'
      end

      private

      def title
        options.fetch(:title)
      end

      def links
        concept('bookie/cell/navigation/link', {
          collection: items,
          active: active,
        })
      end

      def items
        options.fetch(:items)
      end

      def active
        options.fetch(:active)
      end
    end
  end
end
