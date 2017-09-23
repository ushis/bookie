module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell
      class Link < Cell

        def show
          link_to(text, url, class: classes, disabled: disabled?)
        end

        private

        def url
          url_for(params.merge(page: page))
        end

        def page
          options.fetch(:page)
        end

        def params
          options.fetch(:params)
        end

        def disabled?
          options[:disabled]
        end
      end
    end
  end
end
