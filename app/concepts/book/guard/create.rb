class Book < ApplicationRecord
  module Guard
    class Create < Bookie::Guard

      def call
        user.present?
      end
    end
  end
end
