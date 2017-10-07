require_dependency 'bookie/worker'
require_dependency 'user/search/delete'

class User < ApplicationRecord
  module Search
    module Worker
      class Delete < Bookie::Worker

        def perform(user_id)
          Search::Delete.(nil, user_id: user_id)
        end
      end
    end
  end
end
