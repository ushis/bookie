require_dependency 'book'
require_dependency 'book/index/all'
require_dependency 'book/index/search'
require_dependency 'bookie/operation'

class Book < ApplicationRecord
  class Index < Bookie::Operation
    step self::Nested(:finder!)
    step :books!

    def finder!(options, params:, **)
      if params[:q].present?
        Search
      else
        All
      end
    end

    def books!(options, scope:, params:, **)
      options['books'] = scope
        .includes(:cover)
        .order(created_at: :desc)
        .page(params[:page])
        .per(60)
    end
  end
end
