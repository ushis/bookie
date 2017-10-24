require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Plate < Bookie::Cell
          class Received < Plate

            private

            def user
              model.sender
            end
          end
        end
      end
    end
  end
end
