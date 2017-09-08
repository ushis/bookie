require_dependency 'bookie/operation'
require_dependency 'user/session/destroy'

class User < ApplicationRecord
  module Session
    class Destroy < Bookie::Operation
      class Current < Destroy
        step :model!, replace: 'model.build'

        def model!(options, current_session:, **)
          options['model'] = current_session
        end
      end
    end
  end
end
