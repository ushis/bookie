require_dependency 'bookie/cell'
require_dependency 'bookie/cell/tabs/tab'

module Bookie
  class Cell < Trailblazer::Cell
    class Tabs < Cell

      def show
        tag.div(class: classes) do
          tag.ul do
            concept('bookie/cell/tabs/tab', {
              collection: tabs,
              active: active,
            })
          end
        end
      end

      private

      def tabs
        options.fetch(:tabs)
      end

      def active
        options.fetch(:active)
      end

      def classes
        %w(tabs).concat(styles.map { |style| "is-#{style}" })
      end

      def styles
        Array.wrap(options[:style])
      end
    end
  end
end
