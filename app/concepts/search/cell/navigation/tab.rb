module Search
  module Cell
    class Navigation < Bookie::Cell
      class Tab < Bookie::Cell

        def show
          content_tag(:li, class: classes) do
            link_to(url) do
              concat(name)
              concat(content_tag(:span, counter, class: 'badge'))
            end
          end
        end

        private

        def url
          options.fetch(:url)
        end

        def classes
          options.fetch(:active) ? %w(active) : []
        end

        def name
          options.fetch(:name)
        end

        def counter
          options.fetch(:counter)
        end
      end
    end
  end
end
