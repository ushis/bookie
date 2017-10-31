require_dependency 'bookie/operation'
require_dependency 'friendship_request'
require_dependency 'user/friendship/request/guard/show'

class User < ApplicationRecord
  module Friendship
    module Request
      class Show < Bookie::Operation
        step self::Model(::FriendshipRequest, :find_by)
        step self::Policy::Guard(Guard::Show)
        step self::Contract::Build({
          constant: ::Comment::Contract::Create,
          builder: :comment_contract!,
          name: :comment,
        })
        step :comments!

        def comment_contract!(options, constant:, current_user:, model:, **)
          constant.new(::Comment.new, author: current_user, commentable: model)
        end

        def comments!(options, model:, **)
          options['comments'] = model
            .comments
            .includes(author: :avatar)
            .order(created_at: :asc)
        end
      end
    end
  end
end
