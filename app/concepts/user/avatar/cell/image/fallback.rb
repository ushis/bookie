require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Avatar
    module Cell
      class Image < Bookie::Cell
        class Fallback < Image

          private

          def url
            "concepts/user/avatar/fallback/#{version}.png"
          end
        end
      end
    end
  end
end
