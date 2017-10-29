require 'bookie/endpoint'

class User < ApplicationRecord
  module Friendship
    module Request
      module Endpoint
        class Comment < Bookie::Endpoint
          endpoint :success, -> (result) { result.success? }

          endpoint :not_found, -> (result) { result['model'].blank? }

          endpoint :unauthorized, -> (result) {
            result['result.policy.default'].failure?
          }

          endpoint :invalid, -> (result) {
            result['result.contract.comment'].failure?
          }
        end
      end
    end
  end
end
