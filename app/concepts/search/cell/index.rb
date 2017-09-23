require_dependency 'bookie/cell'
require_dependency 'search/cell/results'

module Search
  module Cell
    class Index < Bookie::Cell

      private

      def books
        options.fetch(:books)
      end

      def users
        options.fetch(:users)
      end

      def tab
        options.fetch(:tab)
      end

      def q
        options.fetch(:q)
      end

      def navigation
        concept('search/cell/navigation', nil, {
          q: q,
          active: tab,
          books_count: books.total_count,
          users_count: users.total_count,
        })
      end

      def results
        concept('search/cell/results', nil, {
          q: q,
          tab: tab,
          books: books,
          users: users,
        })
      end
    end
  end
end
