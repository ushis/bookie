require 'ipaddr'

require_dependency 'bookie/operation'

class User < ApplicationRecord
  module Session
    module IP
      class Anonymize < Bookie::Operation
        IPV4_MASK = 16
        IPV6_MASK = 64

        step :parse!
        step :mask!
        step :anonymize!

        def parse!(options, ip_address:, **)
          options['ip'] = IPAddr.new(ip_address)
        rescue IPAddr::AddressFamilyError, IPAddr::InvalidAddressError
          false
        end

        def mask!(options, ip:, **)
          options['mask'] = ip.ipv4? ? IPV4_MASK : IPV6_MASK
        end

        def anonymize!(options, ip:, mask:, **)
          options['ip_address'] = ip.mask(mask).to_s
        end
      end
    end
  end
end
