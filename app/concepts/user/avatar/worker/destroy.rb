require_dependency 'avatar'
require_dependency 'bookie/worker'
require_dependency 'user/avatar/destroy'

class User < ApplicationRecord
  module Avatar
    module Worker
      class Destroy < Bookie::Worker

        def perform(avatar_id)
          Avatar::Destroy.(nil, model: ::Avatar.find(avatar_id))
        end
      end
    end
  end
end
