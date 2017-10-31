require_dependency 'application_record'
require_dependency 'bookie/operation'
require_dependency 'friendship_request'
require_dependency 'user/friendship/create'
require_dependency 'user/friendship/request/guard/accept'

class User < ApplicationRecord
  module Friendship
    module Request
      class Accept < Bookie::Operation
        step self::Model(::FriendshipRequest, :find_by)
        step self::Policy::Guard(Guard::Accept)

        step(self::Wrap(-> (*, &block) { ::ApplicationRecord.transaction(&block) }) {
          step :friendship!
          step :accept!
        })

        def friendship!(options, model:, **)
          Friendship::Create.(nil, {
            user: model.receiver,
            friend: model.sender,
          }).success?
        end

        def accept!(options, model:, **)
          model.update_attribute(:state, 'accepted')
        end
      end
    end
  end
end
