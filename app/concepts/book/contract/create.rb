class Book < ApplicationRecord
  module Contract
    class Create < Bookie::Contract
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

          def unique?(value)
            !Book.exists?(isbn: value)
          end
        end

        required(:isbn).filled(:isbn?, :unique?)
        required(:title).filled(max_size?: 255)
        required(:authors).maybe(max_size?: 255)
      end
    end
  end
end
