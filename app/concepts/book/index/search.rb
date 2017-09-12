require_dependency 'book'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Index < Bookie::Operation
    class Search < Bookie::Operation
      step :q!
      step :query!
      step :scope!

      def q!(options, params:, **)
        options['q'] = params[:q].to_s.strip
      end

      def query!(options, q:, **)
        options['query'] = "%#{q}%"
      end

      def scope!(options, query:, **)
        options['scope'] = Book
          .where('isbn ilike ?', query)
          .or(Book.where('title ilike ?', query))
          .or(Book.where('authors ilike ?', query))
      end
    end
  end
end
