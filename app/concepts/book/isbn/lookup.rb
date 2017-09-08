class Book < ApplicationRecord
  module ISBN
    class Lookup < Bookie::Operation
      step -> (options, isbn:, **) {
        [Google, WorldCat, OpenLibrary].any? { |operation|
          operation.(nil, isbn: isbn).tap { |result|
            options['attributes'] = result['attributes']
          }.success?
        }
      }
    end
  end
end
