require_dependency 'book/cover/lookup'
require_dependency 'book/cover/proxy'
require_dependency 'bookie/operation'
require_dependency 'cover'

class Book < ApplicationRecord
  module Cover
    class Create < Bookie::Operation
      step self::Nested(Lookup)
      step self::Model(::Cover)
      step :proxy!
      step :fetch!
      step :process!
      step :save!

      def proxy!(options, model:, isbn:, **)
        options['proxy'] = Proxy.new(model, isbn: isbn)
      end

      def fetch!(options, url:, **)
        options['image'] = Dragonfly.app.fetch_url(url)
      end

      def process!(options, proxy:, image:, **)
        proxy.image(image) do |v|
          v.process!(:large)         { |job| job.thumb('300x').encode('png') }
          v.process!(:small)         { |job| job.thumb('100x').encode('png') }
          v.process!(:large_preview) { |job| job.thumb('300x450#').encode('png') }
          v.process!(:small_preview) { |job| job.thumb('100x150#').encode('png') }
        end
      end

      def save!(options, proxy:, **)
        proxy.save
      end
    end
  end
end
