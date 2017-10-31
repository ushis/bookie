require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Notifications
    module FriendshipRequest
      module Cell
        class Index < Bookie::Cell

          builds do |_, options|
            case options[:tab]
            when :received
              options[:received_friendship_requests].empty? ? Empty : Received
            when :sent
              options[:sent_friendship_requests].empty? ? Empty : Sent
            end
          end

          def show(&block)
            render('index', &block)
          end

          private

          def navigation
            concept('user/notifications/cell/navigation', nil, {
              active: :friendship_requests,
            })
          end

          def tabs
            concept('bookie/cell/tabs', nil, {
              tabs: [{
                id: :received,
                name: 'Received',
                url: notifications_friendship_requests_path(tab: :received),
                counter: open_received_friendship_requests_count,
              }, {
                id: :sent,
                name: 'Sent',
                url: notifications_friendship_requests_path(tab: :sent),
                counter: open_sent_friendship_requests_count,
              }],
              active: tab,
            })
          end

          def state_selector
            concept('bookie/cell/tabs', nil, {
              tabs: [{
                id: :open,
                name: 'Open',
                url: notifications_friendship_requests_path(tab: tab, state: :open),
              }, {
                id: :closed,
                name: 'Closed',
                url: notifications_friendship_requests_path(tab: tab, state: :closed),
              }],
              active: state,
              style: [:toggle, :small],
            })
          end

          def tab
            options.fetch(:tab)
          end

          def state
            options.fetch(:state)
          end

          def open_received_friendship_requests_count
            current_user.received_friendship_requests.where(state: 'open').count
          end

          def open_sent_friendship_requests_count
            current_user.sent_friendship_requests.where(state: 'open').count
          end
        end
      end
    end
  end
end
