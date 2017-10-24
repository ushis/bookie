require 'user/cell/show'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      class Friends < Show

        private

        def models
          options.fetch(:friends)
        end

        def plate(user)
          concept('user/cell/plate', user)
        end
      end
    end
  end
end
