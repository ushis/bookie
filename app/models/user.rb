class User < ApplicationRecord
  has_many :sessions,
    dependent: :destroy

  serialize :auth_meta_data
end
