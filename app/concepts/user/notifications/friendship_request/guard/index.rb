require_dependency 'bookie/guard'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Guard
        class Index < Bookie::Guard

          def call
            user.present?
          end
        end
      end
    end
  end
end
