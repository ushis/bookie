module Bookie
  class Guard
    extend Uber::Callable

    def self.call(current_user:, model: nil, **)
      new(user: current_user, model: model).()
    end

    attr_reader :user, :model

    def initialize(user:, model:)
      @user = user
      @model = model
    end

    def call
      false
    end
  end
end
