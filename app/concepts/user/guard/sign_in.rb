class User < ApplicationRecord
  module Guard
    class SignIn < Bookie::Guard

      def call
        !user.present?
      end
    end
  end
end
