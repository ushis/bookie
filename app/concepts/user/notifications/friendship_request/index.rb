require_dependency 'bookie/operation'
require_dependency 'user/notifications/friendship_request/guard/index'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      class Index < Bookie::Operation
        TABS = [:received, :sent]
        STATES = [:open, :closed]

        step self::Policy::Guard(Guard::Index)
        step :tab!
        step :state!
        step :received_friendship_requests!
        step :sent_friendship_requests!

        def tab!(options, params:, **)
          options['tab'] = TABS.find { |tab| tab.to_s == params[:tab] } || TABS.first
        end

        def state!(options, params:, **)
          options['state'] = STATES.find { |state| state.to_s == params[:state] } || STATES.first
        end

        def received_friendship_requests!(options, current_user:, params:, state:, **)
          options['received_friendship_requests'] = current_user
            .received_friendship_requests
            .state('open', state == :open)
            .includes(sender: :avatar)
            .order(created_at: :desc)
            .page(params[:page])
            .per(50)
        end

        def sent_friendship_requests!(options, current_user:, params:, state:, **)
          options['sent_friendship_requests'] = current_user
            .sent_friendship_requests
            .state('open', state == :open)
            .includes(receiver: :avatar)
            .order(created_at: :desc)
            .page(params[:page])
            .per(50)
        end
      end
    end
  end
end
