require_dependency 'bookie/worker'
require_dependency 'user/avatar/lookup'

class User < ApplicationRecord
  module Avatar
    module Worker
      class Lookup < Bookie::Worker

        def perform(user_id)
          Avatar::Lookup.(nil, user: User.find(user_id))
        end
      end
    end
  end
end
