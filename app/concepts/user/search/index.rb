require_dependency 'bookie/search'
require_dependency 'bookie/operation'

class User < ApplicationRecord
  module Search
    class Index < Bookie::Operation
      step :index!

      def index!(options, user:, **)
        Bookie::Search.index({
          index: 'users',
          type: 'user',
          id: user.id,
          body: {
            username: user.username,
          },
        })
      end
    end
  end
end
