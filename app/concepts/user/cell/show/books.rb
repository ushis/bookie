require 'user/cell/show'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      class Books < Show

        def show
          super { render }
        end

        private

        def books
          options.fetch(:books)
        end

        def plate(book)
          concept('book/cell/plate', book)
        end

        def pagination
          concept('bookie/cell/pagination', books, {
            params: {
              controller: :users,
              action: :show,
              id: model.id,
              tab: :books,
            },
          })
        end
      end
    end
  end
end
