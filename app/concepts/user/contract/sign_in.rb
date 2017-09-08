class User < ApplicationRecord
  module Contract
    class SignIn < Bookie::Contract
      model User

      property :login,
        type: Types::Form::Str

      property :password

      validation :default do
        required(:login).filled
        required(:password).filled
      end
    end
  end
end
