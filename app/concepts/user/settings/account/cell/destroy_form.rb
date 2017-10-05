require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Settings
    module Account
      module Cell
        class DestroyForm < Bookie::Cell

          private

          def contract
            options.fetch(:contract)
          end

          def url
            settings_account_path
          end

          def method
            :delete
          end

          def id
            'destroy-form'
          end
        end
      end
    end
  end
end
