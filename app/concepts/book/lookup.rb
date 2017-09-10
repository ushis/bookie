require_dependency 'book'
require_dependency 'book/cover/worker/lookup'
require_dependency 'book/create'
require_dependency 'book/isbn/lookup'
require_dependency 'book/lookup/new'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Lookup < Bookie::Operation
    step self::Nested(New)
    step self::Contract::Validate(key: :book, name: :lookup)
    step self::Contract::Persist(method: :sync, name: :lookup)

    step :find!

    step -> (options, proxy:, **) {
      Cover::Worker::Lookup.perform_async(proxy.isbn)
    }

    step self::Nested(ISBN::Lookup, input: -> (options, mutable_data:, **) {
      {isbn: mutable_data['proxy'].isbn}
    })

    step self::Nested(Book::Create, input: -> (options, mutable_data:, runtime_data:, **) {
      runtime_data.merge({'params' => {book: mutable_data['attributes']}})
    })

    def find!(options, proxy:, **)
      options['model'] = Book.find_by(isbn: proxy.isbn)
      options['model'].present? ? Railway.pass_fast! : true
    end
  end
end
