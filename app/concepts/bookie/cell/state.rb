require_dependency 'bookie/cell'

module Bookie
  class Cell < Trailblazer::Cell
    class State < Cell

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
        tag.div(class: classes) do
          concat(octicon(icon))
          concat(name)
        end
      end

      private

      def classes
        %w(tag is-medium)
      end
    end
  end
end
