class Book < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      property :title

      private

      def cover
        concept('book/cell/cover', model, version: :large)
      end

      def authors
        "by #{model.authors}" if model.authors.present?
      end
    end
  end
end
