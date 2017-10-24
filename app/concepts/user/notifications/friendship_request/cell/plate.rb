require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Plate < Bookie::Cell

          builds do |model, options|
            if model.receiver == options.dig(:context, :current_user)
              Received
            else
              Sent
            end
          end

          def show
            render 'plate'
          end

          private

          def state_icon
            concept('bookie/cell/state_icon', model.state)
          end

          def avatar
            concept('user/cell/avatar', user, version: :small)
          end

          def username
            user.username
          end

          def url
            notifications_friendship_request_path(model)
          end

          def created_at
            concept('bookie/cell/time_ago', model.created_at)
          end
        end
      end
    end
  end
end
