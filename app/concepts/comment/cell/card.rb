require_dependency 'bookie/cell'
require_dependency 'bookie/cell/markdown'
require_dependency 'user/cell/avatar'

class Comment < ApplicationRecord
  module Cell
    class Card < Bookie::Cell

      private

      def id
        "comment-#{model.id}"
      end

      def comment
        concept('bookie/cell/markdown', model.comment)
      end

      def avatar
        concept('user/cell/avatar', model.author, version: :small)
      end

      def username
        link_to(model.author.username, url_to_profile)
      end

      def url_to_profile
        user_path(model.author)
      end

      def created_at
        concept('bookie/cell/time_ago', model.created_at)
      end
    end
  end
end
