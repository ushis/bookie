require_dependency 'user/settings/account/contract/base'

class User < ApplicationRecord
  module Settings
    module Account
      module Contract
        class Destroy < Base
        end
      end
    end
  end
end
