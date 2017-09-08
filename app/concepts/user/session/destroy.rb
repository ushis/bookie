require_dependency 'session'
require_dependency 'bookie/operation'
require_dependency 'user/session/guard/destroy'

class User < ApplicationRecord
  module Session
    class Destroy < Bookie::Operation
      step self::Model(::Session, :find_by)
      step self::Policy::Guard(Guard::Destroy)
      step :destroy!

      def destroy!(options, model:, **)
        model.destroy
      end
    end
  end
end
