require_dependency 'bookie/operation'
require_dependency 'user/settings/account/show'

class User < ApplicationRecord
  module Settings
    module Account
      class Destroy < Bookie::Operation
        step self::Nested(Show)
        step self::Contract::Validate(key: :user, name: :destroy)
        step :destroy!
        step :destroy_avatar!

        def destroy!(options, model:, **)
          model.destroy
        end

        def destroy_avatar!(options, model:, **)
          return true if model.avatar.nil?
          Avatar::Worker::Destroy.perform_async(model.avatar.id)
        end
      end
    end
  end
end
