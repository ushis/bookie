require_dependency 'user/notifications/friendship_request/cell/index'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Index < Bookie::Cell
          class Empty < Index

            def show
              super { concept('bookie/cell/info', message) }
            end

            private

            def message
              I18n.t(state, {
                scope: 'user.notifications.friendship_request.index.empty.message',
              })
            end
          end
        end
      end
    end
  end
end
