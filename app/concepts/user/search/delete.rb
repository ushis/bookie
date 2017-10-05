require_dependency 'bookie/operation'
require_dependency 'bookie/search'

class User < ApplicationRecord
  module Search
    class Delete < Bookie::Operation
      step :delete!

      def delete!(options, user_id:, **)
        Bookie::Search.delete(index: 'users', type: 'user', id: user_id)
      end
    end
  end
end
