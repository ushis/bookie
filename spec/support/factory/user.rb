class Factory
  class User < Factory
    operation ::User::Create

    key :user

    property :username, -> { Faker::Internet.user_name(nil, %w(_ -)) }

    property :email, -> { Faker::Internet.email }

    property :password, -> { Faker::Internet.password }

    property :password_confirmation, -> { password }
  end
end
