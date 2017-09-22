# rubocop:disable Naming/MethodName

module Bookie
  class Operation < Trailblazer::Operation

    module Proxy
      def self.Build(constant)
        step = -> (_operation, options) {
          options['proxy'] = constant.new(options['model'])
        }

        [step, name: 'proxy.build']
      end

      def self.Contract(name:'default', constant:nil, builder:nil)
        builder ||= -> (_options, proxy:, **) { constant.new(proxy) }

        Operation::Contract::Build({
          name: name,
          constant: constant,
          builder: builder,
        })
      end
    end
  end
end
