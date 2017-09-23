require_dependency 'bookie/cell'
require_dependency 'search/cell/results/books'
require_dependency 'search/cell/results/users'

module Search
  module Cell
    class Results < Bookie::Cell

      builds do |_, options|
        case options[:tab]
        when :users
          options[:users].empty? ? Empty : Users
        else
          options[:books].empty? ? Empty : Books
        end
      end

      private

      def q
        options.fetch(:q)
      end

      def tab
        options.fetch(:tab)
      end

      def pagination
        concept('bookie/cell/pagination', models, params: {
          controller: :searches,
          action: :index,
          tab: tab,
          q: q,
        })
      end
    end
  end
end
