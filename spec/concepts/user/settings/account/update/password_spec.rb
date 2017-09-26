require 'rails_helper'

RSpec.describe User::Settings::Account::Update::Password, type: :operation do
  let(:result) { User::Settings::Account::Update::Password.(params, dependencies) }

  let(:params) {
    {
      user: {
        password: password,
        password_confirmation: password_confirmation,
        current_password: current_password,
      },
    }
  }

  let(:password) { Factory::User.password }

  let(:password_confirmation) { password }

  let(:current_password) { current_user_factory.password }

  let(:current_user_factory) { Factory::User.new }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { current_user_factory.create }

  it 'successfully updates the users password' do
    expect(result).to be_success
    expect(result['model']).to eq(current_user)
    expect(User::Proxy::Default.new(result['model']).password).to eq(password)
  end

  context 'without password' do
    let(:password) { ['', nil].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.password'].errors[:password]).to be_present
    end
  end

  context 'with incorrect password confirmation' do
    let(:password_confirmation) { Factory::User.password }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.password'].errors[:password_confirmation]).to be_present
    end
  end

  context 'with incorrect current password' do
    let(:current_password) { Factory::User.password }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.password'].errors[:current_password]).to be_present
    end
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
