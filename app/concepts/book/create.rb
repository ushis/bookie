require_dependency 'book'
require_dependency 'book/contract/create'
require_dependency 'book/cover/create'
require_dependency 'book/guard/create'
require_dependency 'book/proxy/default'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Create < Bookie::Operation
    step self::Policy::Guard(Guard::Create)
    step self::Model(Book, :new)
    step self::Proxy::Build(Proxy::Default)
    step self::Proxy::Contract(constant: Contract::Create)
    step self::Contract::Validate(key: :book)
    step self::Contract::Persist()

    # FIXME move to background job
    success -> (options, model:, **) { Cover::Create.(nil, isbn: model.isbn) }
  end
end
