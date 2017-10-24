class FriendshipRequest < ApplicationRecord
  belongs_to :sender,
    optional: true,
    class_name: '::User'

  belongs_to :receiver,
    optional: true,
    class_name: '::User'

  has_many :comments,
    dependent: :destroy,
    as: :commentable,
    class_name: '::Comment'

  def self.state(state, inclusive=true)
    inclusive ? where(state: state) : where.not(state: state)
  end
end
