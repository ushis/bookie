class Book < ApplicationRecord
  module ISBN
    class Validate < Bookie::Operation
      step self::Nested(:build!)

      def build!(options, isbn:, **)
        case isbn.delete('-').size
        when 10
          ISBN10
        when 13
          ISBN13
        else
          Default
        end
      end
    end
  end
end
