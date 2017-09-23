module Search
  module Cell
    class Navigation < Bookie::Cell

      def show
        tag.ul(class: %w(nav nav-tabs nav-underline)) do
          concat(books_tab)
          concat(users_tab)
        end
      end

      private

      def books_tab
        concept('search/cell/navigation/tab', nil, {
          url: search_path(q: q, tab: :books),
          name: 'Books',
          active: active == :books,
          counter: books_count,
        }).()
      end

      def users_tab
        concept('search/cell/navigation/tab', nil, {
          url: search_path(q: q, tab: :users),
          name: 'Users',
          active: active == :users,
          counter: users_count,
        }).()
      end

      def q
        options.fetch(:q)
      end

      def active
        options.fetch(:active)
      end

      def books_count
        options.fetch(:books_count)
      end

      def users_count
        options.fetch(:users_count)
      end
    end
  end
end
