require_dependency 'session'
require_dependency 'bookie/operation'

class User < ApplicationRecord
  module Session
    class Find < Bookie::Operation
      step Model(::Session, :find_by)
    end
  end
end
