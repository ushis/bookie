require_dependency 'bookie/proxy/attachable/file'
require_dependency 'bookie/proxy/attachable/task'

module Bookie
  class Proxy < Disposable::Twin
    module Attachable
      class Attachment
        attr_reader :meta_data

        def initialize(meta_data)
          @meta_data = meta_data.dup
        end

        def [](version)
          return nil if meta_data[version.to_s].nil?
          File.new(meta_data[version.to_s]['uid'])
        end

        def versions
          meta_data.keys
        end

        def task(upload=nil, &block)
          task = Task.new(self, upload, &block)
          block_given? ? self : task
        end
      end
    end
  end
end
