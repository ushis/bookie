class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Show < Bookie::Cell
          class Sent < Show

            private

            def subtitle
              "You want to be friends with #{username}."
            end

            def username
              model.receiver.username
            end
          end
        end
      end
    end
  end
end
