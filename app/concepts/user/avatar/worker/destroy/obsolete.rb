require_dependency 'bookie/worker'
require_dependency 'user'
require_dependency 'user/avatar/destroy/obsolete'

class User < ApplicationRecord
  module Avatar
    module Worker
      class Destroy < Bookie::Worker
        class Obsolete < Bookie::Worker

          def perform(user_id)
            Avatar::Destroy::Obsolete.(nil, user: User.find(user_id))
          end
        end
      end
    end
  end
end
