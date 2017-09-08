class Book < ApplicationRecord
  has_one :cover,
    primary_key: :isbn,
    foreign_key: :isbn,
    class_name: '::Cover'
end
