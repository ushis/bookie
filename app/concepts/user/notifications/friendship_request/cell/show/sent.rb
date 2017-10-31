class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Show < Bookie::Cell
          class Sent < Show

            private

            def subtitle
              tag.span(class: 'has-links-bold') do
                concat('You want to be friends with ')
                concat(link_to_user)
                concat('.')
              end
            end

            def user
              model.receiver
            end
          end
        end
      end
    end
  end
end
