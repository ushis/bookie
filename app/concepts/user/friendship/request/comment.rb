require_dependency 'user/friendship/request/show'
require_dependency 'user/friendship/request/comment/create'

class User < ApplicationRecord
  module Friendship
    module Request
      class Comment < Bookie::Operation
        step self::Nested(:build!)

        def build!(options, params:, **)
          if params[:comment_and_decline]
            Comment::Create::AndDecline
          else
            Comment::Create
          end
        end
      end
    end
  end
end
