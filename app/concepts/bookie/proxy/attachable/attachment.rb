module Bookie
  class Proxy < Disposable::Twin
    module Attachable
      class Attachment
        attr_reader :meta_data

        delegate :url, :fetch, to: :file

        def initialize(meta_data)
          @meta_data = meta_data.reverse_merge({
            'uid' => nil,
            'versions' => {},
          })
        end

        def file
          return nil if uid.nil?
          File.new(uid)
        end

        def [](version)
          return nil if versions[version.to_s].nil?
          File.new(versions[version.to_s])
        end

        def task(file=nil, &block)
          versions.merge!(Task.new(store_or_fetch(file), &block).versions)
          self
        end

        private

        def uid
          meta_data['uid']
        end

        def versions
          meta_data['versions']
        end

        def store_or_fetch(new_file)
          return file.fetch if new_file.nil?

          Dragonfly.app.create(new_file).tap do |job|
            meta_data['uid'] = job.store
          end
        end
      end
    end
  end
end
