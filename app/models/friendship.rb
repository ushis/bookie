class Friendship < ApplicationRecord
  belongs_to :user,
    optional: true,
    class_name: '::User'

  belongs_to :friend,
    optional: true,
    class_name: '::User'
end
