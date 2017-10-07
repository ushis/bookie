require_dependency 'bookie/operation'
require_dependency 'user/settings/account/show'

class User < ApplicationRecord
  module Settings
    module Account
      module Update
        class Account < Bookie::Operation
          step self::Nested(Show)
          step self::Contract::Validate(key: :user, name: :account)
          step self::Contract::Persist(name: :account)
        end
      end
    end
  end
end
