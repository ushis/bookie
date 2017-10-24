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

  has_many :friendships,
    class_name: '::Friendship'

  has_many :friends,
    through: :friendships,
    source: :friend

  has_many :sent_friendship_requests,
    dependent: :destroy,
    foreign_key: :sender_id,
    class_name: '::FriendshipRequest'

  has_many :received_friendship_requests,
    dependent: :destroy,
    foreign_key: :receiver_id,
    class_name: '::FriendshipRequest'

  has_many :comments,
    dependent: :nullify,
    foreign_key: :author_id,
    class_name: '::Comment'

  has_one :avatar,
    -> { order(created_at: :desc) },
    class_name: '::Avatar'
end
