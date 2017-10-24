require_dependency 'bookie/cell'

module Bookie
  class Cell < Trailblazer::Cell
    class Tabs < Cell
      class Tab < Cell

        def show
          tag.li(class: classes) do
            tag.a(href: url) do
              concat(tag.span(name))
              concat(tag.span(counter, class: 'counter')) if counter?
            end
          end
        end

        private

        def id
          model.fetch(:id)
        end

        def name
          model.fetch(:name)
        end

        def url
          model.fetch(:url)
        end

        def counter
          model[:counter]
        end

        def counter?
          model.key?(:counter)
        end

        def active
          options.fetch(:active)
        end

        def classes
          (id == active) ? %w(is-active) : %w()
        end
      end
    end
  end
end
