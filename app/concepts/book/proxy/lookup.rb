require_dependency 'book/isbn/normalize'
require_dependency 'bookie/proxy'
require_dependency 'bookie/proxy/virtual'

class Book < ApplicationRecord
  module Proxy
    class Lookup < Bookie::Proxy
      include Virtual

      property :isbn
      property :title
      property :authors

      def isbn=(isbn)
        super(ISBN::Normalize.(nil, isbn: isbn)['isbn'])
      end
    end
  end
end
