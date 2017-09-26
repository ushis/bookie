require_dependency 'bookie/guard'

class User < ApplicationRecord
  module Settings
    module Account
      module Guard
        class Update < Bookie::Guard

          def call
            user.present?
          end
        end
      end
    end
  end
end
