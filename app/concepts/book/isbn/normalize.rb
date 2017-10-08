require_dependency 'book/isbn/convert/isbn10'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  module ISBN
    class Normalize < Bookie::Operation
      step :remove_dashes!
      step :convert!

      def remove_dashes!(options, isbn:, **)
        options['isbn'] = isbn.delete('-')
      end

      def convert!(options, isbn:, **)
        return true if isbn.size != 10
        options['isbn'] = Convert::ISBN10.(nil, isbn: isbn)['isbn_13']
      end
    end
  end
end
