require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Index < Bookie::Cell

      private

      def books
        options.fetch(:books)
      end

      def thumbnails
        concept('book/cell/thumbnails', nil, books: books)
      end

      def pagination
        concept('bookie/cell/pagination', books, {
          params: {
            q: options[:q],
            action: :index,
            controller: :books,
          },
        })
      end
    end
  end
end
