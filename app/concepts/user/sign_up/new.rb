require_dependency 'bookie/operation'
require_dependency 'user/guard/sign_up'
require_dependency 'user/new'

class User < ApplicationRecord
  class SignUp < Bookie::Operation
    class New < Bookie::Operation
      step self::Policy::Guard(Guard::SignUp)
      step self::Nested(User::New)
    end
  end
end
