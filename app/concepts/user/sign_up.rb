require_dependency 'bookie/operation'
require_dependency 'user/guard/sign_up'
require_dependency 'user/create'
require_dependency 'user/session/create'

class User < ApplicationRecord
  class SignUp < Bookie::Operation
    step self::Policy::Guard(Guard::SignUp)
    step self::Nested(Create)
    step :session!

    def session!(options, model:, user_agent:, ip_address:, **)
      options['session'] = Session::Create.(nil, {
        user: model,
        user_agent: user_agent,
        ip_address: ip_address,
      })['model']
    end
  end
end
