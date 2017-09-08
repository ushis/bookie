module Bookie
  class Proxy < Disposable::Twin
    module Authenticatable

      def self.included(base)
        base.property(:auth_meta_data, default: Hash.new) do
          include Disposable::Twin::Property::Struct
          property :password_hash
        end
      end

      def password
        BCrypt::Password.new(auth_meta_data.password_hash)
      end

      def password=(password)
        auth_meta_data.password_hash = BCrypt::Password.create(password)
      end
    end
  end
end
