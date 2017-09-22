require_dependency 'bookie/cell'
require_dependency 'user/avatar/cell/image/fallback'
require_dependency 'user/avatar/proxy/default'

class User < ApplicationRecord
  module Avatar
    module Cell
      class Image < Bookie::Cell

        builds do |model, _|
          if model.nil?
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
