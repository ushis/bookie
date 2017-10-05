class User < ApplicationRecord
  has_many :copies,
    dependent: :destroy,
    foreign_key: :owner_id,
    class_name: '::Copy'

  has_many :books,
    through: :copies

  has_many :sessions,
    dependent: :destroy,
    class_name: '::Session'

  has_one :avatar,
    -> { order(created_at: :desc) },
    class_name: '::Avatar'
end
