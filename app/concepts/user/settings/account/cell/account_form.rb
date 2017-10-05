require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Settings
    module Account
      module Cell
        class AccountForm < Bookie::Cell

          private

          def contract
            options.fetch(:contract)
          end

          def url
            settings_account_path
          end

          def id
            'account-form'
          end
        end
      end
    end
  end
end
