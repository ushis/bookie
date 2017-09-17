require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      property :username

      private

      def avatar
        concept('user/cell/avatar', model, version: :large)
      end

      def books
        options.fetch(:books)
      end

      def books_count
        # FIXME use counter cache
        books.total_count
      end

      def list_of_books
        concept('book/cell/list', nil, books: books)
      end

      def pagination
        concept('bookie/cell/pagination', books, {
          params: {
            controller: :users,
            action: :show,
            id: model.id,
          },
        })
      end
    end
  end
end
