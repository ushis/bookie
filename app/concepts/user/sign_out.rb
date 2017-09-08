require_dependency 'bookie/operation'
require_dependency 'user/session/destroy/current'

class User < ApplicationRecord
  class SignOut < Bookie::Operation
    step self::Nested(Session::Destroy::Current)
  end
end
