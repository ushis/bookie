require_dependency 'book/cover/lookup'
require_dependency 'bookie/worker'

class Book < ApplicationRecord
  module Cover
    module Worker
      class Lookup < Bookie::Worker

        def perform(isbn)
          Cover::Lookup.(nil, isbn: isbn)
        end
      end
    end
  end
end
