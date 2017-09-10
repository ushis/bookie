require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cover
    module Cell
      class Image < Bookie::Cell
        class Fallback < Image

          private

          def url
            "concepts/book/cover/fallback/#{version}.png"
          end
        end
      end
    end
  end
end
