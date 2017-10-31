require_dependency 'bookie/cell'

module Bookie
  class Cell < Trailblazer::Cell
    class Markdown < Cell

      def show
        markdown.render(model)
      end

      private

      def markdown
        Redcarpet::Markdown.new(renderer, {
          autolink: true,
          fenced_code_blocks: true,
          no_intra_emphasis: true,
          quote: true,
        })
      end

      def renderer
        Redcarpet::Render::HTML.new({
          escape_html: true,
          hard_wrap: true,
          safe_links_only: true,
        })
      end
    end
  end
end
