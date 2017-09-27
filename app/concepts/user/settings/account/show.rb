require_dependency 'bookie/operation'
require_dependency 'user/proxy/default'
require_dependency 'user/settings/account/contract/update/account'
require_dependency 'user/settings/account/contract/update/password'
require_dependency 'user/settings/account/contract/destroy'
require_dependency 'user/settings/account/guard/show'

class User < ApplicationRecord
  module Settings
    module Account
      class Show < Bookie::Operation
        step self::Policy::Guard(Guard::Show)
        step :model!
        step self::Proxy::Build(Proxy::Default)
        step self::Proxy::Contract(constant: Contract::Update::Account, name: :account)
        step self::Proxy::Contract(constant: Contract::Update::Password, name: :password)
        step self::Proxy::Contract(constant: Contract::Destroy, name: :destroy)

        def model!(options, current_user:, **)
          options['model'] = current_user
        end
      end
    end
  end
end
