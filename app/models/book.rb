class Book < ApplicationRecord
  has_many :copies,
    dependent: :destroy,
    class_name: '::Copy'

  has_many :owners,
    through: :copies

  has_one :cover,
    primary_key: :isbn,
    foreign_key: :isbn,
    class_name: '::Cover'
end
