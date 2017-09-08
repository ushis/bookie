class Book < ApplicationRecord
  module Cell
    class Index < Bookie::Cell

      private

      def books
        options.fetch(:books)
      end

      def pagination
        concept('bookie/cell/pagination', books)
      end
    end
  end
end
