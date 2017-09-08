class Book < ApplicationRecord
  module Cell
    class New < Bookie::Cell

      private

      def contract
        options.fetch(:contract)
      end
    end
  end
end
