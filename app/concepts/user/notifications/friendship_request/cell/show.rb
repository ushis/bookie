require_dependency 'bookie/cell'
require_dependency 'user/notifications/friendship_request/cell/show/received'
require_dependency 'user/notifications/friendship_request/cell/show/sent'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Show < Bookie::Cell

          builds do |model, options|
            if model.receiver == options.dig(:context, :current_user)
              Received
            else
              Sent
            end
          end

          def show
            render 'show'
          end

          private

          def navigation
            concept('user/notifications/cell/navigation', nil, {
              active: :friendship_requests,
            })
          end

          def state
            concept('bookie/cell/state', model.state)
          end

          def comments
            concept('comment/cell/card', collection: options.fetch(:comments))
          end

          def comment_contract
            options.fetch(:comment_contract)
          end

          def comment_form_url
            comment_notifications_friendship_request_path(model)
          end

          def button_to_accept
            button_to('Accept request', accept_notifications_friendship_request_path(model), {
              method: :post,
              class: 'button is-success',
            })
          end

          def show_button_to_accept?
            User::Friendship::Request::Guard::Accept.({
              current_user: current_user,
              model: model,
            })
          end

          def show_button_to_decline?
            User::Friendship::Request::Guard::Decline.({
              current_user: current_user,
              model: model,
            })
          end
        end
      end
    end
  end
end
