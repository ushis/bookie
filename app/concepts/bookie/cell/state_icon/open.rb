require_dependency 'bookie/cell/state_icon'

module Bookie
  class Cell < Trailblazer::Cell
    class StateIcon < Cell
      class Open < StateIcon

        private

        def icon
          'issue-opened'
        end

        def classes
          'has-text-success'
        end
      end
    end
  end
end
