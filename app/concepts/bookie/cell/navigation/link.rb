require_dependency 'bookie/cell'

module Bookie
  class Cell < Trailblazer::Cell
    class Navigation < Cell
      class Link < Bookie::Cell

        def show
          link_to(url, class: classes) {
            concat(tag.span(octicon(icon), class: 'panel-icon'))
            concat(name)
          }
        end

        private

        def id
          model.fetch(:id)
        end

        def url
          model.fetch(:url)
        end

        def name
          model.fetch(:name)
        end

        def icon
          model.fetch(:icon)
        end

        def classes
          %w(panel-block).tap { |classes|
            classes << 'is-active' if active?
          }
        end

        def active?
          id == options.fetch(:active)
        end
      end
    end
  end
end
