require_dependency 'bookie/cell/state_icon'

module Bookie
  class Cell < Trailblazer::Cell
    class StateIcon < Cell
      class Accepted < StateIcon

        private

        def icon
          'issue-closed'
        end

        def classes
          'has-text-info'
        end
      end
    end
  end
end
