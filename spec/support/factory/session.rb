class Factory
  class Session < Factory
    operation ::User::Session::Create

    dependency :user, -> { User.create }
  end
end
