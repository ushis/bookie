class User < ApplicationRecord
  module Session
    module Guard
      class Destroy < Bookie::Guard

        def call
          user == model.user
        end
      end
    end
  end
end
