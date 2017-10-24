require_dependency 'bookie/cell'

class User
  module Notifications
    module Cell
      class Navigation < Bookie::Cell

        private

        def link_to_friendship_requests
          # FIXME: ...
          concept('user/settings/cell/navigation/link', nil, {
            url: notifications_friendship_requests_path,
            name: 'Friendship requests',
            icon: :organization,
            active: active == :friendship_requests,
          })
        end

        def active
          options.fetch(:active)
        end
      end
    end
  end
end
