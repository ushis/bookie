require_dependency 'bookie/cell/state'

module Bookie
  class Cell < Trailblazer::Cell
    class State < Cell
      class Declined < State

        private

        def classes
          super.push('is-danger')
        end

        def icon
          'issue-opened'
        end

        def name
          'Declined'
        end
      end
    end
  end
end
