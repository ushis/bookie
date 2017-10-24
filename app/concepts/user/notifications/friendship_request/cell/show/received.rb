class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Show < Bookie::Cell
          class Received < Show

            private

            def subtitle
              "#{username} wants to be your friend."
            end

            def username
              model.sender.username
            end
          end
        end
      end
    end
  end
end
