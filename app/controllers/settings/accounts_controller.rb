module Settings
  class AccountsController < ApplicationController

    # GET /settings/account
    def show
      run User::Settings::Account::Show do |result|
        render_concept('user/settings/account/cell/show', result['model'], {
          account_contract: result['contract.account'],
          password_contract: result['contract.password'],
        })
        return
      end

      redirect_to root_url
    end

    # PATCH /settings/account
    def update
      result = run User::Settings::Account::Update::Account

      User::Settings::Account::Endpoint::Update.(result) { |m|
        m.success { redirect_to settings_account_url }

        m.unauthorized { redirect_to root_url }

        m.invalid {
          render_concept('user/settings/account/cell/show', result['model'], {
            account_contract: result['contract.account'],
            password_contract: result['contract.password'],
          })
        }
      }
    end

    # PATCH /settings/account/password
    def update_password
      result = run User::Settings::Account::Update::Password

      User::Settings::Account::Endpoint::Update.(result) { |m|
        m.success { redirect_to settings_account_url }

        m.unauthorized { redirect_to root_url }

        m.invalid {
          render_concept('user/settings/account/cell/show', result['model'], {
            account_contract: result['contract.account'],
            password_contract: result['contract.password'],
          })
        }
      }
    end
  end
end
