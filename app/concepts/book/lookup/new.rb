require_dependency 'bookie/operation'
require_dependency 'book/proxy/lookup'

class Book < ApplicationRecord
  class Lookup < Bookie::Operation
    class New < Bookie::Operation
      step self::Policy::Guard(Guard::Lookup)
      step self::Proxy::Build(Proxy::Lookup)
      step self::Proxy::Contract(constant: Contract::Lookup, name: :lookup)
    end
  end
end
