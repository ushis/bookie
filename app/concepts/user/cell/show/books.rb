require 'user/cell/show'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      class Books < Show

        private

        def models
          options.fetch(:books)
        end

        def plate(book)
          concept('book/cell/plate', book)
        end
      end
    end
  end
end
