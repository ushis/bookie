class User < ApplicationRecord
  module Proxy
    class Default < Bookie::Proxy
      include Bookie::Proxy::Authenticatable

      property :id,
        writable: false

      property :username
      property :email
    end
  end
end
