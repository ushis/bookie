require_dependency 'bookie/operation'
require_dependency 'user/contract/sign_in'
require_dependency 'user/guard/sign_in'
require_dependency 'user/proxy/sign_in'

class User < ApplicationRecord
  class SignIn < Bookie::Operation
    class New < Bookie::Operation
      step self::Policy::Guard(Guard::SignIn)
      step self::Proxy::Build(Proxy::SignIn)
      step self::Proxy::Contract(constant: Contract::SignIn)
    end
  end
end
