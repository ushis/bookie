require_dependency 'bookie/operation'
require_dependency 'user/find'

class User < ApplicationRecord
  class Show < Bookie::Operation
    step self::Nested(Find)
    step :books!

    def books!(options, model:, params:, **)
      options['books'] = model
        .books
        .includes(:cover)
        .order('copies.created_at desc')
        .page(params[:page])
        .per(36)
    end
  end
end
