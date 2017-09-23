module Search
  module Cell
    class Navigation < Bookie::Cell
      class Tab < Bookie::Cell

        def show
          link_to(url, class: classes) do
            concat(name)
            concat(content_tag(:span, counter, class: 'counter'))
          end
        end

        private

        def url
          options.fetch(:url)
        end

        def classes
          %w(navbar-item is-tab).tap { |classes|
            classes << 'is-active' if options.fetch(:active)
          }
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
