class Book < ApplicationRecord
  module Endpoint
    class Lookup < Bookie::Endpoint
      endpoint :success, -> (result) { result.success? }

      endpoint :unauthorized, -> (result) {
        result['result.policy.default'].failure?
      }

      endpoint :invalid_isbn, -> (result) {
        result['result.contract.lookup'].failure?
      }

      endpoint :not_found, -> (result) {
        result['attributes'].nil?
      }

      endpoint :invalid_attributes, -> (result) {
        result['result.contract.default'].failure?
      }
    end
  end
end
