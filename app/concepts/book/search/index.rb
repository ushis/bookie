require_dependency 'bookie/operation'
require_dependency 'bookie/search'

class Book < ApplicationRecord
  module Search
    class Index < Bookie::Operation
      step :index!

      def index!(options, book:, **)
        Bookie::Search.index({
          index: 'books',
          type: 'book',
          id: book.id,
          body: {
            isbn: book.isbn,
            title: book.title,
            authors: book.authors,
          },
        })
      end
    end
  end
end
