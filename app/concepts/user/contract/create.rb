require_dependency 'user'
require_dependency 'bookie/contract'

class User < ApplicationRecord
  module Contract
    class Create < Bookie::Contract
      model User

      property :username,
        type: Types::Form::Str

      property :email,
        type: Types::Form::Str

      property :password,
        readable: false

      property :password_confirmation,
        virtual: true

      validation :username do
        configure do
          def unique?(value)
            !User.exists?(username: value)
          end
        end

        required(:username).filled({
          format?: /\A[a-z_\-]+\z/,
          max_size?: 25,
          unique?: true,
        })
      end

      validation :email do
        configure do
          def unique?(value)
            !User.exists?(email: value)
          end
        end

        required(:email).filled({
          format?: /\A.+@.+\z/,
          unique?: true,
        })
      end

      validation :password do
        required(:password).filled.confirmation
      end
    end
  end
end
