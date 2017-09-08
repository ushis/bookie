class Book < ApplicationRecord
  module Contract
    class Lookup < Bookie::Contract
      model Book

      property :isbn,
        type: Types::Form::Str

      property :title,
        type: Types::Form::Str

      property :authors,
        type: Types::Form::Str

      validation :default do
        configure do
          def isbn?(value)
            ISBN::Validate.({}, {isbn: value}).success?
          end
        end

        required(:isbn).filled(:isbn?)
      end
    end
  end
end
