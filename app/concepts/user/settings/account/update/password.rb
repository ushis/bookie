require_dependency 'bookie/operation'
require_dependency 'user/settings/account/show'

class User < ApplicationRecord
  module Settings
    module Account
      module Update
        class Password < Bookie::Operation
          step self::Nested(Show)
          step self::Contract::Validate(key: :user, name: :password)
          step self::Contract::Persist(name: :password)
        end
      end
    end
  end
end
