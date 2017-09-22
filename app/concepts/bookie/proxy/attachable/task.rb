module Bookie
  class Proxy < Disposable::Twin
    module Attachable
      class Task

        def initialize(attachment, file)
          @job = ::Dragonfly.app.create(file)
          @attachment = attachment

          yield(self) if block_given?
        end

        def process!(version)
          job = @job
          job = yield(job) if block_given?
          @attachment.meta_data[version.to_s] = {'uid' => job.store}
        end
      end
    end
  end
end
