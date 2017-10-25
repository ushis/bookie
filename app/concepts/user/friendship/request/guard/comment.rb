require 'user/friendship/request/guard/show'

class User < ApplicationRecord
  module Friendship
    module Request
      module Guard
        class Comment < Show

          def call
            super && model.state == 'open'
          end
        end
      end
    end
  end
end
