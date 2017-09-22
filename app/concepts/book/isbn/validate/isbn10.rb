class Book < ApplicationRecord
  module ISBN
    class Validate < Bookie::Operation
      class ISBN10 < Bookie::Operation
        step :remove_dashes!
        step :digits!
        step :check!

        def remove_dashes!(options, isbn:, **)
          options['isbn'] = isbn.delete('-')
        end

        def digits!(options, isbn:, **)
          options['digits'] = isbn.split('').map { |digit|
            (digit.casecmp('x') == 0) ? 10 : Integer(digit)
          }
        rescue TypeError, ArgumentError
          false
        end

        def check!(options, digits:, **)
          digits.each_with_index.reduce(0) { |sum, (digit, index)|
            sum + (digit * (index + 1))
          } % 11 == 0
        end
      end
    end
  end
end
