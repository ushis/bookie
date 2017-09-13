class Avatar < ApplicationRecord
  belongs_to :user,
    optional: true,
    class_name: '::User'
end
