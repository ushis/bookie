require_dependency 'avatar'
require_dependency 'bookie/operation'
require_dependency 'user/avatar/proxy/default'

class User < ApplicationRecord
  module Avatar
    class Lookup < Bookie::Operation
      ENDPOINT = 'https://robohash.org/:key?bgset=bg2'

      step :find!
      step :keys!
      step :hash!
      step :url!
      step self::Model(::Avatar)
      step :proxy!
      step :fetch!
      step :process!
      step :save!

      def find!(options, user:, **)
        options['model'] = user.avatar
        options['model'].present? ? Railway.pass_fast! : true
      end

      def keys!(options, user:, **)
        options['keys'] = [user.username, user.email]
      end

      def hash!(options, keys:, **)
        options['hash'] = Digest::SHA1.hexdigest(keys.join('-'))
      end

      def url!(options, hash:, **)
        options['url'] = ENDPOINT.sub(':key', hash)
      end

      def proxy!(options, model:, user:, **)
        options['proxy'] = Proxy::Default.new(model, user: user)
      end

      def fetch!(options, url:, **)
        options['image'] = Dragonfly.app.fetch_url(url)
      end

      def process!(options, proxy:, image:, **)
        proxy.image(image) do |v|
          v.process!(:large) { |job| job.thumb('300x300#').encode('png') }
          v.process!(:small) { |job| job.thumb('44x44#').encode('png') }
          v.process!(:tiny)  { |job| job.thumb('20x20#').encode('png') }
        end
      end

      def save!(options, proxy:, **)
        proxy.save
      end
    end
  end
end
