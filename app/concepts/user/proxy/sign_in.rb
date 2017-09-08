require_dependency 'bookie/proxy'
require_dependency 'bookie/proxy/virtual'

class User < ApplicationRecord
  module Proxy
    class SignIn < Bookie::Proxy
      include Virtual

      property :login
      property :password
    end
  end
end
