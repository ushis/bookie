require_dependency 'book'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Find < Bookie::Operation
    step self::Model(Book, :find_by)
  end
end
