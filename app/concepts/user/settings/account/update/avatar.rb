require_dependency 'bookie/operation'
require_dependency 'user/avatar/save'
require_dependency 'user/settings/account/show'

class User < ApplicationRecord
  module Settings
    module Account
      module Update
        class Avatar < Bookie::Operation
          step self::Nested(Show)
          step self::Contract::Validate(key: :user, name: :avatar)
          step :save!

          def save!(options, current_user:, **)
            User::Avatar::Save.(nil, {
              user: current_user,
              image: options['contract.avatar'].avatar.image,
            }).success?
          end
        end
      end
    end
  end
end
