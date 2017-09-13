require_dependency 'bookie/operation'
require_dependency 'user'

class User < ApplicationRecord
  class Find < Bookie::Operation
    step self::Model(User, :find_by)
  end
end
