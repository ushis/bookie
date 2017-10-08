require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Settings
    module Security
      module Cell
        class Show < Bookie::Cell

          private

          def navigation
            concept('user/settings/cell/navigation', nil, active: :security)
          end

          def sessions
            options.fetch(:sessions)
          end
        end
      end
    end
  end
end
