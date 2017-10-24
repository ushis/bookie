require_dependency 'bookie/cell'

module Bookie
  class Cell < Trailblazer::Cell
    class TimeAgo < Cell

      def show
        tag.span(content, attributes)
      end

      private

      def content
        I18n.l(model, format: '%b %d, %Y')
      end

      def attributes
        {data: {'time-ago': model.iso8601}}
      end
    end
  end
end
