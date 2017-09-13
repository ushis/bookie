require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      property :username

      private

      def avatar
        concept('user/cell/avatar', model, version: :large)
      end
    end
  end
end
