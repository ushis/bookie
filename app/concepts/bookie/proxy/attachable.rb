module Bookie
  class Proxy < Disposable::Twin
    module Attachable

      def self.included(base)
        base.extend(ClassMethods)
      end

      private

      def attachable(name, file=nil, &block)
        Attachment.new(send("#{name}_meta_data")).tap do |attachment|
          if !file.nil? || !block.nil?
            send("#{name}_meta_data=", attachment.task(file, &block).meta_data)
          end
        end
      end

      module ClassMethods

        def attachable(name)
          property("#{name}_meta_data", default: Hash.new)

          define_method(name) { |file=nil, &block|
            attachable(name, file, &block)
          }
        end
      end
    end
  end
end
