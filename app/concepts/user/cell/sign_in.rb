require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class SignIn < Bookie::Cell

      private

      def contract
        options.fetch(:contract)
      end

      def submit_url
        sign_in_path
      end

      def show_error?
        options[:error].present?
      end

      def error_message
        I18n.t(options.fetch(:error), scope: 'user.sign_in.errors')
      end

      def link_to_sign_up
        link_to('Create an account.', sign_up_path)
      end
    end
  end
end
