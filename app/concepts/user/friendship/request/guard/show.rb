require_dependency 'bookie/guard'

class User < ApplicationRecord
  module Friendship
    module Request
      module Guard
        class Show < Bookie::Guard

          def call
            user == model.sender || user == model.receiver
          end
        end
      end
    end
  end
end
