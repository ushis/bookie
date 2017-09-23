module Bookie
  class Cell < Trailblazer::Cell
    class Layout < Cell
      include ActionView::Helpers::CsrfHelper

      private

      # FIXME
      def title
        'Bookie'
      end

      def show_navigation?
        true
      end

      def body_classes
        []
      end
    end
  end
end
