class Cover < ApplicationRecord
  belongs_to :book,
    optional: true,
    foreign_key: :isbn,
    primary_key: :isbn,
    class_name: '::Book'
end
