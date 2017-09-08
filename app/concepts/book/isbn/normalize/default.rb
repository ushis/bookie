class Book < ApplicationRecord
  module ISBN
    class Normalize < Bookie::Operation
      class Default < Bookie::Operation
        step :remove_dashes!

        def remove_dashes!(options, isbn:, **)
          options['isbn'] = isbn.delete('-')
        end
      end
    end
  end
end
