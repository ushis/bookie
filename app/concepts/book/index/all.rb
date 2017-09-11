require_dependency 'book'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Index < Bookie::Operation
    class All < Bookie::Operation
      step :scope!

      def scope!(options, **)
        options['scope'] = Book.all
      end
    end
  end
end
