require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Cover < Bookie::Cell

      def show
        concept('book/cover/cell/image', cover, version: version, alt: alt)
      end

      private

      def cover
        model.cover
      end

      def version
        options.fetch(:version)
      end

      def alt
        "Cover of #{model.title}"
      end
    end
  end
end
