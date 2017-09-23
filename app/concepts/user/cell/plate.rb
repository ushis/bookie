class User < ApplicationRecord
  module Cell
    class Plate < Bookie::Cell
      property :username

      private

      def url
        user_path(model)
      end

      def avatar
        concept('user/cell/avatar', model, version: :small)
      end
    end
  end
end
