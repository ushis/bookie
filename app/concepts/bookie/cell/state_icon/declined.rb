require_dependency 'bookie/cell/state_icon'

module Bookie
  class Cell < Trailblazer::Cell
    class StateIcon < Cell
      class Declined < StateIcon

        private

        def icon
          'issue-opened'
        end

        def classes
          'has-text-danger'
        end
      end
    end
  end
end
