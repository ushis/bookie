class Book < ApplicationRecord
  module ISBN
    class Normalize < Bookie::Operation
      class ISBN10 < Bookie::Operation
        step :remove_dashes!
        step :digits!
        step :pad!
        step :checksum!
        step :combine!
        step :join!

        def remove_dashes!(options, isbn:, **)
          options['isbn'] = isbn.delete('-')
        end

        def digits!(options, isbn:, **)
          options['digits'] = isbn.split('')[0..8].map { |digit| Integer(digit) }
        rescue TypeError, ArgumentError
          false
        end

        def pad!(options, digits:, **)
          options['digits'] = [9, 7, 8].concat(digits)
        end

        def checksum!(options, digits:, **)
          options['checksum'] = digits.each_with_index.reduce(0) { |sum, (digit, index)|
            sum + (digit * (index.even? ? 1 : 3))
          } % 10
        end

        def combine!(options, digits:, checksum:, **)
          options['digits'] = digits.push((10 - checksum) % 10)
        end

        def join!(options, digits:, **)
          options['isbn'] = digits.join
        end
      end
    end
  end
end
