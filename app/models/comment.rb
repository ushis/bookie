class Comment < ApplicationRecord
  belongs_to :commentable,
    optional: true,
    polymorphic: true

  belongs_to :author,
    optional: true,
    class_name: '::User'
end
