require_dependency 'user/notifications/friendship_request/cell/index'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Index < Bookie::Cell
          class Sent < Index

            def show
              super { render 'index/friendship_requests' }
            end

            private

            def sent_friendship_requests
              options.fetch(:sent_friendship_requests)
            end

            def plates
              concept('user/notifications/friendship_request/cell/plate', {
                collection: sent_friendship_requests,
              })
            end

            def pagination
              concept('bookie/cell/pagination', sent_friendship_requests, {
                params: {
                  controller: 'notifications/friendship_requests',
                  action: :index,
                  tab: :sent,
                  state: state,
                },
              })
            end
          end
        end
      end
    end
  end
end
