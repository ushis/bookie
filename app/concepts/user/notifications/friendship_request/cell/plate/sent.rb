require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Plate < Bookie::Cell
          class Sent < Plate

            private

            def user
              model.receiver
            end
          end
        end
      end
    end
  end
end
