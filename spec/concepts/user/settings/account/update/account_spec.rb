require 'rails_helper'

RSpec.describe User::Settings::Account::Update::Account, type: :operation do
  let(:result) { User::Settings::Account::Update::Account.(params, dependencies) }

  let(:params) {
    {
      user: {
        username: username,
        email: email,
        current_password: current_password,
      },
    }
  }

  let(:username) { Factory::User.username }

  let(:email) { Factory::User.email }

  let(:current_password) { current_user_factory.password }

  let(:current_user_factory) { Factory::User.new }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { current_user_factory.create }

  it 'successfully updates the account settings' do
    expect(result).to be_success
    expect(result['model']).to eq(current_user)
    expect(result['model'].username).to eq(current_user_factory.username)
    expect(result['model'].email).to eq(email)
  end

  context 'with invalid email' do
    let(:email) { ['   ', 'invalid'].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.account'].errors[:email]).to be_present
    end
  end

  context 'with wrong password' do
    let(:current_password) { Factory::User.password }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.account'].errors[:current_password]).to be_present
    end
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
