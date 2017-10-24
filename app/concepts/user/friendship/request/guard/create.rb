require_dependency 'bookie/guard'

class User < ApplicationRecord
  module Friendship
    module Request
      module Guard
        class Create < Bookie::Guard

          def call
            signed_in? &&
              stranger? &&
              !friends? &&
              !any_received_friendship_requests? &&
              !any_sent_friendship_requests?
          end

          private

          def signed_in?
            user.present?
          end

          def stranger?
            user != model
          end

          def friends?
            user.friends.include?(model)
          end

          def any_received_friendship_requests?
            user.received_friendship_requests.exists?(sender: model)
          end

          def any_sent_friendship_requests?
            user.sent_friendship_requests.exists?(receiver: model)
          end
        end
      end
    end
  end
end
