require_dependency 'bookie/guard'

class User < ApplicationRecord
  module Friendship
    module Request
      module Guard
        class Accept < Bookie::Guard

          def call
            model.state == 'open' && user == model.receiver
          end
        end
      end
    end
  end
end
