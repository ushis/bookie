module Bookie
  class Proxy < Disposable::Twin
    module Attachable
      class Task

        def initialize(job, &block)
          @job = job
          @versions = {}

          block.call(self) if !block.nil?
        end

        def process!(version)
          @versions[version.to_s] = yield(@job).store
        end

        def versions
          @versions.dup
        end
      end
    end
  end
end
