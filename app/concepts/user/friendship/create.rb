require_dependency 'application_record'
require_dependency 'bookie/operation'
require_dependency 'friendship'

class User < ApplicationRecord
  module Friendship
    class Create < Bookie::Operation
      step :friendships!
      step :save!

      def friendships!(options, user:, friend:, **)
        options['friendships'] = [
          ::Friendship.new(user: user, friend: friend),
          ::Friendship.new(user: friend, friend: user),
        ]
      end

      def save!(options, friendships:, **)
        ApplicationRecord.transaction { friendships.each(&:save) }
      end
    end
  end
end
