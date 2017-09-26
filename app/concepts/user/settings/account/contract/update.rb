require_dependency 'bookie/contract'
require_dependency 'user'

class User < ApplicationRecord
  module Settings
    module Account
      module Contract
        class Update < Bookie::Contract
          model User

          property :current_password,
            virtual: true

          validation :current_password do
            configure do
              option :form

              def correct?(value)
                form.model.password == value
              end
            end

            required(:current_password).filled(:correct?)
          end
        end
      end
    end
  end
end
