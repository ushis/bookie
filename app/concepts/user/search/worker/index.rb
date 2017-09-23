require_dependency 'bookie/worker'
require_dependency 'user'
require_dependency 'user/search/index'

class User < ApplicationRecord
  module Search
    module Worker
      class Index < Bookie::Worker

        def perform(user_id)
          Search::Index.(nil, user: User.find(user_id))
        end
      end
    end
  end
end
