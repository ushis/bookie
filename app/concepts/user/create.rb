require_dependency 'user/avatar/worker/lookup'
require_dependency 'user/new'

class User < ApplicationRecord
  class Create < New
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist()

    step -> (options, model:, **) {
      Avatar::Worker::Lookup.perform_async(model.id)
    }
  end
end
