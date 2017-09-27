require_dependency 'user/settings/account/contract/base'

class User < ApplicationRecord
  module Settings
    module Account
      module Contract
        module Update
          class Password < Base

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
