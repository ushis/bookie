require_dependency 'bookie/cell/state'

module Bookie
  class Cell < Trailblazer::Cell
    class State < Cell
      class Open < State

        private

        def classes
          super.push('is-success')
        end

        def icon
          'issue-opened'
        end

        def name
          'Open'
        end
      end
    end
  end
end
