require_dependency 'bookie/endpoint'
require_dependency 'user/settings/account/endpoint/show'

class User < ApplicationRecord
  module Settings
    module Account
      module Endpoint
        class Update < Show
          endpoint :invalid, -> (result) {
            result['result.contract.account'].try(:failure?) ||
              result['result.contract.password'].try(:failure?) ||
              result['result.contract.destroy'].try(:failure?)
          }
        end
      end
    end
  end
end
