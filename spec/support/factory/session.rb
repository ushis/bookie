class Factory
  class Session < Factory
    operation ::User::Session::Create

    dependency :user, -> { User.create }

    dependency :user_agent, -> { Faker::Internet.user_agent }

    dependency :ip_address, -> {
      [
        Faker::Internet.ip_v4_address,
        Faker::Internet.ip_v6_address,
      ].sample
    }
  end
end
