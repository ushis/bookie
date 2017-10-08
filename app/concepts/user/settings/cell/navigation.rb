require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Settings
    module Cell
      class Navigation < Bookie::Cell

        private

        def link_to_account
          concept('user/settings/cell/navigation/link', nil, {
            url: settings_account_path,
            name: 'Account',
            icon: :person,
            active: active == :account,
          })
        end

        def link_to_security
          concept('user/settings/cell/navigation/link', nil, {
            url: settings_security_path,
            name: 'Security',
            icon: :shield,
            active: active == :security,
          })
        end

        def active
          options.fetch(:active)
        end
      end
    end
  end
end
