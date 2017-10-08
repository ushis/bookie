require_dependency 'bookie/operation'
require_dependency 'user/settings/security/guard/show'

class User < ApplicationRecord
  module Settings
    module Security
      class Show < Bookie::Operation
        step self::Policy::Guard(Guard::Show)
        step :model!
        step :sessions!

        def model!(options, current_user:, **)
          options['model'] = current_user
        end

        def sessions!(options, model:, **)
          options['sessions'] = model.sessions.order(created_at: :desc)
        end
      end
    end
  end
end
