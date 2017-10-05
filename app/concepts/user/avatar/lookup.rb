require_dependency 'bookie/operation'
require_dependency 'user/avatar/save'

class User < ApplicationRecord
  module Avatar
    class Lookup < Bookie::Operation
      ENDPOINT = 'https://robohash.org/:key?bgset=bg2'

      step :keys!
      step :hash!
      step :url!
      step :fetch!
      step :save!

      def keys!(options, user:, **)
        options['keys'] = [user.username, user.email]
      end

      def hash!(options, keys:, **)
        options['hash'] = Digest::SHA1.hexdigest(keys.join('-'))
      end

      def url!(options, hash:, **)
        options['url'] = ENDPOINT.sub(':key', hash)
      end

      def fetch!(options, url:, **)
        options['image'] = Dragonfly.app.fetch_url(url)
      end

      def save!(options, user:, image:, **)
        Save.(nil, user: user, image: image).tap { |result|
          options['model'] = result['model']
        }.success?
      end
    end
  end
end
