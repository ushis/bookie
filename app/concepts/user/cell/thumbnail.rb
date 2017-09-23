require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    class Thumbnail < Bookie::Cell

      private

      def url_to_user
        user_path(model)
      end

      def classes
        %w(thumbnail).tap { |classes|
          classes << 'thumbnail-card thumbnail-card-sm' if options[:card]
        }
      end

      def username
        model.username
      end

      def avatar
        concept('user/cell/avatar', model, version: version)
      end

      def version
        options.fetch(:version)
      end
    end
  end
end
