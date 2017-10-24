require_dependency 'bookie/cell/state'

module Bookie
  class Cell < Trailblazer::Cell
    class State < Cell
      class Accepted < State

        private

        def classes
          super.push('is-info')
        end

        def icon
          'issue-closed'
        end

        def name
          'Accepted'
        end
      end
    end
  end
end
