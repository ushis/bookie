require_dependency 'book/cover/proxy/default'
require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cover
    module Cell
      class Image < Bookie::Cell

        def show
          image_tag(url, alt: alt)
        end

        private

        def url
          if model.present? # FIXME move to builder
            Proxy::Default.new(model).image[version].url
          else
            "concepts/book/cover/fallback/#{version}.png"
          end
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
