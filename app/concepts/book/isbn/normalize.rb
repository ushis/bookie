class Book < ApplicationRecord
  module ISBN
    class Normalize < Bookie::Operation
      step self::Nested(:build!)

      def build!(options, isbn:, **)
        case isbn.delete('-').size
        when 10
          ISBN10
        else
          Default
        end
      end
    end
  end
end
