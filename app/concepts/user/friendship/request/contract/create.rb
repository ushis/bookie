require_dependency 'bookie/contract'
require_dependency 'comment'
require_dependency 'friendship_request'

class User < ApplicationRecord
  module Friendship
    module Request
      module Contract
        class Create < Bookie::Contract
          model ::FriendshipRequest

          property :sender,
            parse: false

          property :receiver,
            parse: false

          property :state,
            parse: false,
            default: 'open'

          collection :comments, populate_if_empty: -> (*) { Comment.new } do
            property :author,
              parse: false

            property :comment,
              type: Types::Form::Str

            validation :default do
              required(:author).filled
              required(:comment).filled
            end
          end

          validation :default do
            required(:sender).filled
            required(:receiver).filled
            required(:comments).filled(size?: 1)
          end
        end
      end
    end
  end
end
