require_dependency 'user/avatar/proxy/default'
require_dependency 'user/avatar/save'
require_dependency 'user/avatar/worker/destroy/obsolete'

class User < ApplicationRecord
  module Avatar
    class Save < Bookie::Operation
      step :model!
      step :proxy!
      step :process!
      step :save!
      step :destroy_obsolete!

      def model!(options, user:, **)
        options['model'] = ::Avatar.new(user: user)
      end

      def proxy!(options, model:, **)
        options['proxy'] = Proxy::Default.new(model)
      end

      def process!(options, proxy:, image:, **)
        proxy.image(image) do |v|
          v.process!(:original)
          v.process!(:large) { |job| job.thumb('300x300#').encode('png') }
          v.process!(:small) { |job| job.thumb('44x44#').encode('png') }
          v.process!(:tiny)  { |job| job.thumb('20x20#').encode('png') }
        end
      end

      def save!(options, proxy:, **)
        proxy.save
      end

      def destroy_obsolete!(options, user:, **)
        Worker::Destroy::Obsolete.perform_async(user.id)
      end
    end
  end
end
