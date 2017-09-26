require_dependency 'user/settings/account/contract/update'

class User < ApplicationRecord
  module Settings
    module Account
      module Contract
        class Update < Bookie::Contract
          class Password < Update

            property :password,
              readable: false

            property :password_confirmation,
              virtual: true

            validation :password do
              required(:password).filled.confirmation
            end
          end
        end
      end
    end
  end
end
