class Book < ApplicationRecord
  module ISBN
    class Validate < Bookie::Operation
      class Default < Bookie::Operation
        step :check!

        def check!(options, **)
          false
        end
      end
    end
  end
end
