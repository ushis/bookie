class User < ApplicationRecord
  module Proxy
    class Default < Bookie::Proxy
      include Bookie::Proxy::Authenticatable

      property :username
      property :email
    end
  end
end
