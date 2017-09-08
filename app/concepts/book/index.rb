require_dependency 'book'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Index < Bookie::Operation
    step :books!

    def books!(options, params:, **)
      options['books'] = Book
        .includes(:cover)
        .order(created_at: :desc)
        .page(params[:page])
        .per(60)
    end
  end
end
