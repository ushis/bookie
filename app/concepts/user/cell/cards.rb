require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class Cards < Bookie::Cell

      private

      def users
        options.fetch(:users)
      end

      def card(user)
        concept('user/cell/thumbnail', user, card: true, version: :small)
      end
    end
  end
end
