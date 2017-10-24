require_dependency 'friendship_request'
require_dependency 'user/friendship/request/guard/create'
require_dependency 'user/show'

class User < ApplicationRecord
  module Friendship
    module Request
      class Create < User::Show
        step self::Policy::Guard(Guard::Create)
        step self::Contract::Validate({
          key: :friendship_request,
          name: :friendship_request,
        })
        step self::Contract::Persist(name: :friendship_request)
      end
    end
  end
end
