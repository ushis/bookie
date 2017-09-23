require_dependency 'book/cover/cell/image/fallback'
require_dependency 'book/cover/proxy/default'
require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cover
    module Cell
      class Image < Bookie::Cell

        builds do |model, _|
          case model
          when nil
            Fallback
          else
            Image
          end
        end

        def show
          image_tag(url, alt: alt)
        end

        private

        def url
          Proxy::Default.new(model).image[version].url
        end

        def version
          options.fetch(:version)
        end

        def alt
          options[:alt]
        end
      end
    end
  end
end
