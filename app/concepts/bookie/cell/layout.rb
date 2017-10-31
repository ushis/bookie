require_dependency 'bookie/cell/layout/navigation'

module Bookie
  class Cell < Trailblazer::Cell
    class Layout < Cell
      include ActionView::Helpers::CsrfHelper

      private

      # FIXME
      def title
        'Bookie'
      end

      def body_classes
        []
      end

      def show_navigation?
        true
      end

      def navigation
        concept('bookie/cell/layout/navigation')
      end
    end
  end
end
