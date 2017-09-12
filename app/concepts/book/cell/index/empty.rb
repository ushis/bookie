require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Index < Bookie::Cell
      class Empty < Bookie::Cell

        private

        def q
          options.fetch(:q)
        end
      end
    end
  end
end
