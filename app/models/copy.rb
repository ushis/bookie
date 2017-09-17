class Copy < ApplicationRecord
  belongs_to :book,
    optional: true,
    class_name: '::Book'

  belongs_to :owner,
    optional: true,
    class_name: '::User'
end
