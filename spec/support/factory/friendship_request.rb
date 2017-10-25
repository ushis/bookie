class Factory
  class FriendshipRequest < Factory
    operation ::User::Friendship::Request::Create

    key :friendship_request

    param :id, -> { User.create.id }

    property :comments, -> { [{comment: Faker::Lorem.paragraph}] }

    dependency :current_user, -> { User.create }
  end
end
