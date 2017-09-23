require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Thumbnails < Bookie::Cell

      private

      def books
        options.fetch(:books)
      end

      def thumbnail(book)
        concept('book/cell/thumbnail', book, version: :large_preview)
      end
    end
  end
end
