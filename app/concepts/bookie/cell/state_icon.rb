

module Bookie
  class Cell < Trailblazer::Cell
    class StateIcon < Cell

      builds do |model, _|
        case model
        when 'open'
          Open
        when 'accepted'
          Accepted
        when 'declined'
          Declined
        end
      end

      def show
        octicon(icon, class: classes)
      end
    end
  end
end
