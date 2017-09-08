class User < ApplicationRecord
  module Guard
    class SignUp < Bookie::Guard

      def call
        !user.present?
      end
    end
  end
end
