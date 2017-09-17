require_dependency 'bookie/guard'

class Book < ApplicationRecord
  module Copy
    module Guard
      class Create < Bookie::Guard

        def call
          user.present?
        end
      end
    end
  end
end
