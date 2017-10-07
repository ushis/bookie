require_dependency 'bookie/contract'
require_dependency 'user'
require_dependency 'user/avatar/contract/upload'
require_dependency 'user/avatar/proxy/upload'

class User < ApplicationRecord
  module Settings
    module Account
      module Contract
        module Update
          class Avatar < Bookie::Contract
            model User

            property :avatar,
              virtual: true,
              default: -> { User::Avatar::Proxy::Upload.new(nil) },
              form: User::Avatar::Contract::Upload
          end
        end
      end
    end
  end
end
