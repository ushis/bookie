require_dependency 'bookie/proxy'
require_dependency 'bookie/proxy/attachable'

class Book < ApplicationRecord
  module Cover
    class Proxy < Bookie::Proxy
      include Bookie::Proxy::Attachable

      property :isbn

      attachable :image
    end
  end
end
