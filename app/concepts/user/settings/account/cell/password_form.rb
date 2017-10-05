require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Settings
    module Account
      module Cell
        class PasswordForm < Bookie::Cell

          private

          def contract
            options.fetch(:contract)
          end

          def url
            password_settings_account_path
          end

          def id
            'password-form'
          end
        end
      end
    end
  end
end
