require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      property :username

      builds do |_, options|
        case options[:tab]
        when :books
          Books
        when :friends
          Friends
        end
      end

      def show
        render 'show'
      end

      private

      def avatar
        concept('user/cell/avatar', model, version: :large)
      end

      def button_to_friendship_request_modal
        concept('user/cell/friendship/request/modal', model, {
          contract: options.fetch(:friendship_request_contract),
        })
      end

      def tabs
        concept('bookie/cell/tabs', nil, {
          tabs: [{
            id: :books,
            url: user_path(model, tab: :books),
            name: 'Books',
            counter: model.books.count,
          }, {
            id: :friends,
            url: user_path(model, tab: :friends),
            name: 'Friends',
            counter: model.friends.count,
          }],
          active: tab,
        })
      end

      def tab
        options.fetch(:tab)
      end

      def pagination
        concept('bookie/cell/pagination', models, {
          params: {
            controller: :users,
            action: :show,
            id: model.id,
            tab: tab,
          },
        })
      end
    end
  end
end
