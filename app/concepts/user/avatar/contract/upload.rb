require_dependency 'avatar'
require_dependency 'bookie/contract'

class User < ApplicationRecord
  module Avatar
    module Contract
      class Upload < Bookie::Contract
        model ::Avatar

        property :image

        validation :image do
          configure do
            def image_type?(types, value)
              types.include?(Dragonfly.app.create(value).format)
            rescue StandardError
              false
            end

            def max_file_size?(max_size, value)
              Filesize.from(max_size).to_i >= value.size
            end
          end

          required(:image).filled({
            max_file_size?: '2 MB',
            image_type?: %w(jpeg png),
          })
        end
      end
    end
  end
end
