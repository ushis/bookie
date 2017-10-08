require_dependency 'bookie/guard'

class User < ApplicationRecord
  module Settings
    module Security
      module Guard
        class Show < Bookie::Guard

          def call
            user.present?
          end
        end
      end
    end
  end
end
