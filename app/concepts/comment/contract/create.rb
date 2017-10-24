require_dependency 'bookie/contract'
require_dependency 'comment'

class Comment < ApplicationRecord
  module Contract
    class Create < Bookie::Contract
      model Comment

      property :author
      property :commentable

      property :comment,
        type: Types::Form::Str

      validation :default do
        required(:author).filled
        required(:commentable).filled
        required(:comment).filled
      end
    end
  end
end
