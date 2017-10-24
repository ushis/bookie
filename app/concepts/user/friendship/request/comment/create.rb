require_dependency 'user/friendship/request/show'

class User < ApplicationRecord
  module Friendship
    module Request
      class Comment < Bookie::Operation
        class Create < Show
          step self::Contract::Validate(key: :comment, name: :comment)
          step self::Contract::Persist(name: :comment)
        end
      end
    end
  end
end
