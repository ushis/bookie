require 'rails_helper'

RSpec.describe User::Settings::Account::Show, type: :operation do
  let(:result) { User::Settings::Account::Show.(nil, dependencies) }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { Factory::User.create }

  it 'successfully finds the user and builds the account & password contracts' do
    expect(result).to be_success
    expect(result['model']).to eq(current_user)
    expect(result['contract.account'].username).to eq(current_user.username)
    expect(result['contract.account'].email).to eq(current_user.email)
    expect(result['contract.account'].current_password).to eq(nil)
    expect(result['contract.password'].password).to eq(nil)
    expect(result['contract.password'].password_confirmation).to eq(nil)
    expect(result['contract.password'].current_password).to eq(nil)
    expect(result['contract.destroy'].current_password).to eq(nil)
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
