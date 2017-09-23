class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def render_concept(name, model, dependencies={})
    render(concept(name, model, {
      context: {
        current_user: current_user,
        current_session: current_session,
      },
      layout: Bookie::Cell::Layout,
    }.deep_merge(dependencies)), layout: false)
  end

  def _run_options(options)
    options.reverse_merge({
      current_user: current_user,
      current_session: current_session,
    })
  end

  def current_user
    @current_user ||= current_session.try(:user)
  end

  def current_session
    @current_session ||= User::Session::Find.({
      id: cookies.permanent.encrypted[:session_id],
    })['model']
  end
end
