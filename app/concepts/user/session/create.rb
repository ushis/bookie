require_dependency 'session'
require_dependency 'bookie/operation'

class User < ApplicationRecord
  module Session
    class Create < Bookie::Operation
      step :model!
      step :persist!

      def model!(options, user:, **)
        options['model'] = ::Session.new(user: user)
      end

      def persist!(options, model:, **)
        model.save
      end
    end
  end
end
