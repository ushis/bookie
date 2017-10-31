require_dependency 'bookie/cell/navigation'

class User
  module Notifications
    module Cell
      class Navigation < Bookie::Cell::Navigation

        private

        def title
          'Notifications'
        end

        def items
          [{
            id: :friendship_requests,
            url: notifications_friendship_requests_path,
            name: 'Friendship requests',
            icon: :organization,
          }]
        end
      end
    end
  end
end
