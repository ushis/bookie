require_dependency 'bookie/operation'
require_dependency 'user/proxy/default'
require_dependency 'user/settings/account/contract/update'
require_dependency 'user/settings/account/guard/update'

class User < ApplicationRecord
  module Settings
    module Account
      class Show < Bookie::Operation
        step self::Policy::Guard(Guard::Update)
        step :model!
        step self::Proxy::Build(Proxy::Default)
        step self::Proxy::Contract(constant: Contract::Update::Account, name: :account)
        step self::Proxy::Contract(constant: Contract::Update::Password, name: :password)

        def model!(options, current_user:, **)
          options['model'] = current_user
        end
      end
    end
  end
end
