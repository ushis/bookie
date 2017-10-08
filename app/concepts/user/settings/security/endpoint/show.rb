require_dependency 'bookie/endpoint'

class User < ApplicationRecord
  module Settings
    module Security
      module Endpoint
        class Show < Bookie::Endpoint
          endpoint :success, -> (result) { result.success? }

          endpoint :unauthorized, -> (result) {
            result['result.policy.default'].failure?
          }
        end
      end
    end
  end
end
