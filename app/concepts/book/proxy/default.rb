class Book < ApplicationRecord
  module Proxy
    class Default < Bookie::Proxy
      property :isbn
      property :title
      property :authors

      def isbn=(isbn)
        super(ISBN::Normalize.(nil, isbn: isbn)['isbn'])
      end
    end
  end
end
