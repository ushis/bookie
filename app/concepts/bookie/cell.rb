module Bookie
  class Cell < Trailblazer::Cell
    include Escaped
    include ::Cell::Builder

    include OcticonsHelper

    include SimpleForm::ActionViewExtensions::FormHelper

    private

    def current_user
      context.fetch(:current_user)
    end

    def current_session
      context.fetch(:current_session)
    end

    # rails hackery
    #
    # https://github.com/trailblazer/cells-rails/issues/23
    def protect_against_forgery?
      context.fetch(:controller).send(:protect_against_forgery?)
    end

    def form_authenticity_token(*args)
      context.fetch(:controller).send(:form_authenticity_token, *args)
    end
  end
end
