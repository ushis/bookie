class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Show < Bookie::Cell
          class Received < Show

            private

            def subtitle
              tag.span(:span, class: 'has-links-bold') do
                concat(link_to_user)
                concat(' wants to be your friend.')
              end
            end

            def user
              model.sender
            end
          end
        end
      end
    end
  end
end
