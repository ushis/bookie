require_dependency 'bookie/operation'

class Book < ApplicationRecord
  module ISBN
    module Convert
      class ISBN13 < Bookie::Operation
        step :check!
        step :digits!
        step :checksum!
        step :check_digit!
        step :combine!
        step :join!

        def check!(options, isbn:, **)
          isbn.start_with?('978')
        end

        def digits!(options, isbn:, **)
          options['digits'] = isbn.split('')[3..11].map { |digit| Integer(digit) }
        rescue TypeError, ArgumentError
          false
        end

        def checksum!(options, digits:, **)
          options['checksum'] = digits
            .each_with_index
            .reduce(0) { |sum, (digit, index)| sum + (digit * (index + 1)) }
        end

        def check_digit!(options, checksum:, **)
          options['check_digit'] = checksum % 11
        end

        def combine!(options, digits:, check_digit:, **)
          options['digits'] = digits.push((check_digit == 10) ? 'X' : check_digit)
        end

        def join!(options, digits:, **)
          options['isbn_10'] = digits.join
        end
      end
    end
  end
end
