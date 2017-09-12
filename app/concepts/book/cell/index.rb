require_dependency 'book/cell/index/empty'
require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Index < Bookie::Cell

      builds do |_, options|
        if options.fetch(:books).empty?
          Empty
        else
          Index
        end
      end

      private

      def books
        options.fetch(:books)
      end

      def pagination
        concept('bookie/cell/pagination', books, {
          params: {
            q: options[:q],
            action: :index,
            controller: :books,
          }
        })
      end
    end
  end
end
