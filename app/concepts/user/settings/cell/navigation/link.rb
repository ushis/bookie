require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Settings
    module Cell
      class Navigation < Bookie::Cell
        class Link < Bookie::Cell

          def show
            link_to(url, class: classes) {
              concat(tag.span(octicon(icon), class: 'panel-icon'))
              concat(name)
            }
          end

          private

          def url
            options.fetch(:url)
          end

          def name
            options.fetch(:name)
          end

          def icon
            options.fetch(:icon)
          end

          def classes
            %w(panel-block).tap { |classes|
              classes << 'is-active' if active?
            }
          end

          def active?
            options.fetch(:active)
          end
        end
      end
    end
  end
end
