require_dependency 'bookie/endpoint'
require_dependency 'user/settings/account/endpoint/update'

class User < ApplicationRecord
  module Settings
    module Account
      module Endpoint
        class Destroy < Update
        end
      end
    end
  end
end
