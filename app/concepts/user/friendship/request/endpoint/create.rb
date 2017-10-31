require 'bookie/endpoint'

class User < ApplicationRecord
  module Friendship
    module Request
      module Endpoint
        class Create < Bookie::Endpoint
          endpoint :success, -> (result) { result.success? }

          endpoint :not_found, -> (result) { result['model'].blank? }

          endpoint :unauthorized, -> (result) {
            result['result.policy.default'].failure?
          }

          endpoint :invalid, -> (result) {
            result['result.contract.friendship_request'].failure?
          }
        end
      end
    end
  end
end
