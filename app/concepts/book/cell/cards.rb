require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Cards < Bookie::Cell

      private

      def books
        options.fetch(:books)
      end

      def card(book)
        concept('book/cell/thumbnail', book, {
          card: true,
          version: :small_preview,
        })
      end
    end
  end
end
