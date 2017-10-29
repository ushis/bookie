require 'bookie/cell'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class CommentForm < Bookie::Cell

          def show
            super if show?
          end

          private

          def id
            'comment-form'
          end

          def url_to_profile
            user_path(current_user)
          end

          def avatar
            concept('user/cell/avatar', current_user, version: :small)
          end

          def contract
            options.fetch(:contract)
          end

          def url
            comment_notifications_friendship_request_path(model, anchor: id)
          end

          def show?
            User::Friendship::Request::Guard::Comment.({
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
