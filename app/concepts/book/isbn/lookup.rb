class Book < ApplicationRecord
  module ISBN
    class Lookup < Bookie::Operation
      step :lookup!

      def lookup!(options, isbn:, **)
        [Google, WorldCat, OpenLibrary].any? { |operation|
          operation.(nil, isbn: isbn).tap { |result|
            options['attributes'] = result['attributes']
          }.success?
        }
      end
    end
  end
end
