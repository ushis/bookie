require_dependency 'bookie/operation'
require_dependency 'user'
require_dependency 'user/proxy/default'
require_dependency 'user/session/create'
require_dependency 'user/sign_in/new'

class User < ApplicationRecord
  class SignIn < Bookie::Operation
    step self::Nested(New)
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist(method: :sync)
    step :model!
    step :authenticate!
    step :session!
    failure :error!

    def model!(options, proxy:, **)
      options['model'] = User
        .where(username: proxy.login)
        .or(User.where(email: proxy.login))
        .first
    end

    def authenticate!(options, model:, proxy:, **)
      Proxy::Default.new(model).password == proxy.password
    end

    def session!(options, model:, user_agent:, ip_address:, **)
      options['session'] = Session::Create.({}, {
        user: model,
        user_agent: user_agent,
        ip_address: ip_address,
      })['model']
    end

    def error!(options, **)
      options['error'] = :invalid_credentials
    end
  end
end
