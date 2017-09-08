require_dependency 'bookie/endpoint'

class Book < ApplicationRecord
  module Endpoint
    class Create < Bookie::Endpoint
      endpoint :success, -> (result) { result.success? }

      endpoint :unauthorized, -> (result) {
        result['result.policy.default'].failure?
      }

      endpoint :invalid, -> (result) {
        result['result.contract.default'].failure?
      }
    end
  end
end
