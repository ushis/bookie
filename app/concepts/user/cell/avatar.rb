require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class Avatar < Bookie::Cell

      def show
        concept('user/avatar/cell/image', avatar, version: version, alt: alt)
      end

      private

      def avatar
        model.avatar
      end

      def version
        options.fetch(:version)
      end

      def alt
        "Avatar of #{model.username}"
      end
    end
  end
end
