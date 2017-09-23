class Book < ApplicationRecord
  module Cell
    class Plate < Bookie::Cell

      private

      def url
        book_path(model)
      end

      def title
        model.title.to_s.truncate(100)
      end

      def authors
        model.authors.to_s.truncate(70)
      end

      def cover
        concept('book/cell/cover', model, version: :small_preview)
      end
    end
  end
end
