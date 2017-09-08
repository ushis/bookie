require_dependency 'user/new'

class User < ApplicationRecord
  class Create < New
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist()
  end
end
