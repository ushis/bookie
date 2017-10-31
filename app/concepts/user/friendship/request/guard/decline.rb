require_dependency 'user/friendship/request/guard/accept'

class User < ApplicationRecord
  module Friendship
    module Request
      module Guard
        class Decline < Accept
        end
      end
    end
  end
end
