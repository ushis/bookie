require_dependency 'bookie/operation'

class Book < ApplicationRecord
  module ISBN
    module Convert
      class ISBN10 < Bookie::Operation
        step :digits!
        step :pad!
        step :checksum!
        step :check_digit!
        step :combine!
        step :join!

        def digits!(options, isbn:, **)
          options['digits'] = isbn.split('')[0..8].map { |digit| Integer(digit) }
        rescue TypeError, ArgumentError
          false
        end

        def pad!(options, digits:, **)
          options['digits'] = [9, 7, 8].concat(digits)
        end

        def checksum!(options, digits:, **)
          options['checksum'] = digits
            .each_with_index
            .reduce(0) { |sum, (digit, index)| sum + (digit * (index.even? ? 1 : 3)) }
        end

        def check_digit!(options, checksum:, **)
          options['check_digit'] = (10 - (checksum % 10)) % 10
        end

        def combine!(options, digits:, check_digit:, **)
          options['digits'] = digits.push(check_digit)
        end

        def join!(options, digits:, **)
          options['isbn_13'] = digits.join
        end
      end
    end
  end
end
