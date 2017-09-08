module Bookie
  class Proxy < Disposable::Twin
    module Virtual

      def self.included(base)
        base.extend(ClassMethods)
      end

      def persisted?
        false
      end

      def to_key
        nil
      end

      module ClassMethods

        def property(name, options={})
          super(name, options.reverse_merge(virtual: true))
        end
      end
    end
  end
end
