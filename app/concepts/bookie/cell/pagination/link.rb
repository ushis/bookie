module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell
      class Link < Cell

        private

        def url
          url_for(page: page)
        end

        def page
          options.fetch(:page)
        end

        def classes
          %w(btn btn-default).tap { |classes|
            classes << 'disabled' if disabled?
          }
        end

        def disabled?
          !!options[:disabled]
        end
      end
    end
  end
end
