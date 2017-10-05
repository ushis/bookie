require_dependency 'avatar'
require_dependency 'bookie/operation'
require_dependency 'user/avatar/destroy'

class User < ApplicationRecord
  module Avatar
    class Destroy < Bookie::Operation
      class Obsolete < Bookie::Operation
        step :avatars!
        step :destroy!

        def avatars!(options, user:, **)
          options['avatars'] = ::Avatar
            .where(user: user)
            .order(created_at: :desc)
            .offset(1)
        end

        def destroy!(options, avatars:, **)
          avatars.all? { |model| Destroy.(nil, model: model).success? }
        end
      end
    end
  end
end
