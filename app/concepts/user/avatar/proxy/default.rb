require_dependency 'bookie/proxy'
require_dependency 'bookie/proxy/attachable'

class User < ApplicationRecord
  module Avatar
    module Proxy
      class Default < Bookie::Proxy
        include Attachable

        property :user

        attachable :image
      end
    end
  end
end
