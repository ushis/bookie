require_dependency 'book'
require_dependency 'book/search/index'
require_dependency 'bookie/worker'

class Book < ApplicationRecord
  module Search
    module Worker
      class Index < Bookie::Worker

        def perform(book_id)
          Search::Index.(nil, book: Book.find(book_id))
        end
      end
    end
  end
end
