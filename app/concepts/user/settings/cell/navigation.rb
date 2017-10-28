require_dependency 'bookie/cell/navigation'

class User < ApplicationRecord
  module Settings
    module Cell
      class Navigation < Bookie::Cell::Navigation

        private

        def title
          'Personal settings'
        end

        def items
          [{
            id: :account,
            url: settings_account_path,
            name: 'Account',
            icon: :person,
          }, {
            id: :security,
            url: settings_security_path,
            name: 'Security',
            icon: :shield,
          }]
        end
      end
    end
  end
end
