require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Index < Bookie::Cell

      private

      def books
        options.fetch(:books)
      end

      def thumbnail(book)
        concept('book/cell/thumbnail', book, version: :large_preview)
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
