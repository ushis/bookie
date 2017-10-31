require_dependency 'bookie/cell'

module Bookie
  class Cell < Trailblazer::Cell
    class Info < Cell

      private

      def icon
        octicon('info')
      end

      def message
        model
      end
    end
  end
end
