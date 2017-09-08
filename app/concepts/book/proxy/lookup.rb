class Book < ApplicationRecord
  module Proxy
    class Lookup < Bookie::Proxy
      include Bookie::Proxy::Virtual

      property :isbn
      property :title
      property :authors

      def isbn=(isbn)
        super(ISBN::Normalize.(nil, isbn: isbn)['isbn'])
      end
    end
  end
end
