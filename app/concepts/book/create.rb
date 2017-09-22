require_dependency 'book'
require_dependency 'book/contract/create'
require_dependency 'book/guard/create'
require_dependency 'book/proxy/default'
require_dependency 'book/search/worker/index'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Create < Bookie::Operation
    step self::Policy::Guard(Guard::Create)
    step self::Model(Book, :new)
    step self::Proxy::Build(Proxy::Default)
    step self::Proxy::Contract(constant: Contract::Create)
    step self::Contract::Validate(key: :book)
    step self::Contract::Persist()
    step :index!

    def index!(options, model:, **)
      Search::Worker::Index.perform_async(model.id)
    end
  end
end
