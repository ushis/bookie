require_dependency 'user/avatar/worker/lookup'
require_dependency 'user/new'
require_dependency 'user/search/worker/index'

class User < ApplicationRecord
  class Create < New
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist()
    step :avatar!
    step :index!

    def avatar!(options, model:, **)
      Avatar::Worker::Lookup.perform_async(model.id)
    end

    def index!(options, model:, **)
      Search::Worker::Index.perform_async(model.id)
    end
  end
end
