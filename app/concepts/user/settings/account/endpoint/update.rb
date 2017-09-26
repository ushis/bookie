require_dependency 'bookie/endpoint'

class User < ApplicationRecord
  module Settings
    module Account
      module Endpoint
        class Update < Bookie::Endpoint
          endpoint :success, -> (result) { result.success? }

          endpoint :unauthorized, -> (result) {
            result['result.policy.default'].failure?
          }

          endpoint :invalid, -> (result) {
            result['result.contract.account'].try(:failure?) ||
              result['result.contract.password'].try(:failure?)
          }
        end
      end
    end
  end
end
