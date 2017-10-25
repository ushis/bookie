require_dependency 'user/friendship/request/show'
require_dependency 'user/friendship/request/guard/comment'

class User < ApplicationRecord
  module Friendship
    module Request
      class Comment < Bookie::Operation
        class Create < Show
          step self::Policy::Guard(Guard::Comment), replace: 'policy.default.eval'
          step self::Contract::Validate(key: :comment, name: :comment)
          step self::Contract::Persist(name: :comment)
        end
      end
    end
  end
end
