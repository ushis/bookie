module Bookie
  class Cell < Trailblazer::Cell
    class Pagination < Cell
      class Link < Cell

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

        def classes
          %w(btn btn-default).tap { |classes|
            classes << 'disabled' if disabled?
          }
        end

        def disabled?
          options[:disabled]
        end
      end
    end
  end
end
