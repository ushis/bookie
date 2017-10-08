module Settings
  class SecuritiesController < ApplicationController

    # GET /settings/security
    def show
      result = run User::Settings::Security::Show

      User::Settings::Security::Endpoint::Show.(result) do |m|
        m.success { render_show(result) }
        m.unauthorized { redirect_to(root_url) }
      end
    end

    # DELETE /settings/security/sessions/:id
    def destroy_session
      run User::Session::Destroy
      redirect_to settings_security_url
    end

    private

    def render_show(result)
      render_concept('user/settings/security/cell/show', result['model'], {
        sessions: result['sessions'],
      })
    end
  end
end
