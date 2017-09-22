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

      validation :default do
        required(:username).filled(format?: /\A[a-z_\-]+\z/, max_size?: 25)
        required(:email).filled(format?: /\A.+@.+\z/)
        required(:password).filled
        required(:password_confirmation).filled
      end

      validation :username do
        configure do
          def unique?(value)
            !User.exists?(username: value)
          end
        end

        required(:username).filled(:unique?)
      end

      validation :email do
        configure do
          def unique?(value)
            !User.exists?(email: value)
          end
        end

        required(:email).filled(:unique?)
      end

      validation :password do
        configure do
          option :form

          def confirmed?(value)
            value == form.password
          end
        end

        required(:password_confirmation).filled(:confirmed?)
      end
    end
  end
end
