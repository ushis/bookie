class Factory
  class Book < Factory
    operation ::Book::Create

    key :book

    dependency :current_user, -> { User.create }

    property :isbn, -> {
      ::Book::ISBN::Normalize.({}, {
        isbn: (1..10).map { |_| rand(10) }.join,
      })['isbn']
    }

    property :title, -> { Faker::Book.title }

    property :authors, -> { Faker::Book.author }
  end
end
