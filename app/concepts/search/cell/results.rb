require_dependency 'bookie/cell'
require_dependency 'search/cell/results/books'
require_dependency 'search/cell/results/users'

module Search
  module Cell
    class Results < Bookie::Cell

      builds do |_, options|
        case options[:tab]
        when :users
          Users
        else
          Books
        end
      end

      private

      def books
        options.fetch(:books)
      end

      def users
        options.fetch(:users)
      end

      def q
        options.fetch(:q)
      end
    end
  end
end
