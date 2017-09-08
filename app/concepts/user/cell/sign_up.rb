require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class SignUp < Bookie::Cell

      private

      def contract
        options.fetch(:contract)
      end

      def submit_url
        sign_up_path
      end

      def link_to_sign_in
        link_to('Sign in.', sign_in_path)
      end
    end
  end
end
