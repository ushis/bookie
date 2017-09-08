class Book < ApplicationRecord
  module Cell
    class Lookup < Bookie::Cell

      private

      def contract
        options.fetch(:contract)
      end

      def submit_url
        lookup_books_url
      end
    end
  end
end
