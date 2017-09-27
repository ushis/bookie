require_dependency 'bookie/proxy/attachable/file'

module Bookie
  class Proxy < Disposable::Twin
    module Attachable
      class Task

        def initialize(attachment, upload)
          @attachment = attachment
          @upload = upload

          yield(self) if block_given?
        end

        def process!(version, &block)
          (@attachment[version] || File.new(gen_uid)).tap { |file|
            @attachment.meta_data[version.to_s] = {
              'uid' => file.process!(@upload, &block),
            }
          }
        end

        def destroy!(*versions)
          versions.concat(@attachment.versions) if versions.empty?

          versions.each { |version|
            @attachment[version].destroy!
            @attachment.meta_data.delete(version.to_s)
          }
        end

        private

        def gen_uid
          SecureRandom.uuid
        end
      end
    end
  end
end
