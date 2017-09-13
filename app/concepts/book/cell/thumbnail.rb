require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Thumbnail < Bookie::Cell

      private

      def url_to_book
        book_path(model)
      end

      def title
        model.title.truncate(100)
      end

      def cover
        concept('book/cell/cover', model, version: version)
      end

      def version
        options.fetch(:version)
      end
    end
  end
end
