require_dependency 'bookie/proxy'
require_dependency 'bookie/proxy/virtual'

class User < ApplicationRecord
  module Avatar
    module Proxy
      class Upload < Bookie::Proxy
        include Virtual

        property :image
      end
    end
  end
end
