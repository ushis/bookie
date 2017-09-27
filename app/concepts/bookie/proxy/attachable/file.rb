module Bookie
  class Proxy < Disposable::Twin
    module Attachable
      class File
        attr_reader :uid

        def initialize(uid)
          @uid = uid
        end

        def url
          Dragonfly.app.remote_url_for(uid)
        end

        def fetch
          Dragonfly.app.fetch(uid)
        end

        def process!(upload)
          job = Dragonfly.app.create(upload)
          job = yield(job) if block_given?
          job.store(uid: uid)
        end

        def destroy!
          Dragonfly.app.destroy(uid)
        end
      end
    end
  end
end
