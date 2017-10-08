require_dependency 'session'
require_dependency 'bookie/operation'
require_dependency 'user/session/ip/anonymize'

class User < ApplicationRecord
  module Session
    class Create < Bookie::Operation
      success self::Nested(IP::Anonymize)
      step :model!
      step :persist!

      def model!(options, user:, user_agent:, ip_address:, **)
        options['model'] = ::Session.new({
          user: user,
          user_agent: user_agent,
          ip_address: ip_address,
        })
      end

      def persist!(options, model:, **)
        model.save
      end
    end
  end
end
