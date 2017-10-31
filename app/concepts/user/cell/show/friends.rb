require 'user/cell/show'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      class Friends < Show

        def show
          super { render }
        end

        private

        def friends
          options.fetch(:friends)
        end

        def plate(user)
          concept('user/cell/plate', user)
        end

        def pagination
          concept('bookie/cell/pagination', friends, {
            params: {
              controller: :users,
              action: :show,
              id: model.id,
              tab: :friends,
            },
          })
        end
      end
    end
  end
end
