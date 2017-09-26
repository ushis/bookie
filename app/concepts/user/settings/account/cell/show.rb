require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Settings
    module Account
      module Cell
        class Show < Bookie::Cell

          private

          def navigation
            concept('user/settings/cell/navigation', nil, active: :account)
          end

          def account_form
            concept('user/settings/account/cell/account_form', nil, {
              contract: options.fetch(:account_contract),
            })
          end

          def password_form
            concept('user/settings/account/cell/password_form', nil, {
              contract: options.fetch(:password_contract),
            })
          end
        end
      end
    end
  end
end
