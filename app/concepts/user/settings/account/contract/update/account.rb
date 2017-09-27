require_dependency 'user/settings/account/contract/base'

class User < ApplicationRecord
  module Settings
    module Account
      module Contract
        module Update
          class Account < Base

            property :username,
              writeable: false

            property :email,
              type: Types::Form::Str

            validation :email do
              configure do
                option :form

                def unique?(value)
                  !User.where.not(id: form.model.id).exists?(email: value)
                end
              end

              required(:email).filled(format?: /\A.+@.+\z/, unique?: true)
            end
          end
        end
      end
    end
  end
end
