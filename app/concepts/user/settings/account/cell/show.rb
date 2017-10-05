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

          def avatar
            concept('user/cell/avatar', model, version: :large)
          end

          def account_form
            concept('user/settings/account/cell/account_form', nil, {
              contract: options.fetch(:account_contract),
            })
          end

          def avatar_form
            concept('user/settings/account/cell/avatar_form', nil, {
              contract: options.fetch(:avatar_contract),
            })
          end

          def password_form
            concept('user/settings/account/cell/password_form', nil, {
              contract: options.fetch(:password_contract),
            })
          end

          def destroy_form
            concept('user/settings/account/cell/destroy_form', nil, {
              contract: options.fetch(:destroy_contract),
            })
          end
        end
      end
    end
  end
end
