class Book < ApplicationRecord
  module Cell
    class Form < Bookie::Cell

      private

      def contract
        options.fetch(:contract)
      end

      def submit_url
        books_path
      end
    end
  end
end
