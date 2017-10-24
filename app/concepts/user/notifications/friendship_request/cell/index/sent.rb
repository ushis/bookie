require_dependency 'user/notifications/friendship_request/cell/index'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Index < Bookie::Cell
          class Sent < Index

            private

            def friendship_requests
              options.fetch(:sent_friendship_requests)
            end
          end
        end
      end
    end
  end
end
