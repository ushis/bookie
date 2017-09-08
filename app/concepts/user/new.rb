require_dependency 'user'
require_dependency 'bookie/operation'
require_dependency 'user/proxy/default'
require_dependency 'user/contract/create'

class User < ApplicationRecord
  class New < Bookie::Operation
    step self::Model(User, :new)
    step self::Proxy::Build(Proxy::Default)
    step self::Proxy::Contract(constant: Contract::Create)
  end
end
