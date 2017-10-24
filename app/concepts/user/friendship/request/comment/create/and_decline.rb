require_dependency 'user/friendship/request/comment/create'
require_dependency 'user/friendship/request/guard/decline'

class User < ApplicationRecord
  module Friendship
    module Request
      class Comment < Bookie::Operation
        class Create < Show
          class AndDecline < Create
            step self::Policy::Guard(Guard::Decline), replace: 'policy.default.eval'
            step :decline!

            def decline!(options, model:, **)
              model.update_attribute(:state, 'declined')
            end
          end
        end
      end
    end
  end
end
