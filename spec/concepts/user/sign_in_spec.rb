require 'rails_helper'

RSpec.describe User::SignIn, type: :operation do
  let(:result) { User::SignIn.(params, dependencies) }

  let(:params) {
    {
      user: {
        login: login,
        password: password,
      },
    }
  }

  let(:login) { factory.username }

  let(:password) { factory.password }

  let(:factory) { Factory::User.new }

  let(:dependencies) {
    {
      current_user: current_user,
      user_agent: user_agent,
      ip_address: ip_address,
    }
  }

  let(:current_user) { nil }

  let(:user_agent) { Factory::Session.user_agent }

  let(:ip_address) { Factory::Session.ip_address }

  let(:anonymized_ip_address) {
    User::Session::IP::Anonymize.(nil, ip_address: ip_address)['ip_address']
  }

  let!(:user) { factory.create }

  it 'successfully creates a new session' do
    expect(result).to be_success
    expect(result['session']).to be_persisted
    expect(result['session'].user).to eq(user)
    expect(result['session'].user_agent).to eq(user_agent)
    expect(result['session'].ip_address).to eq(anonymized_ip_address)
  end

  context 'with email' do
    let(:login) { factory.email }

    it 'successfully creates a new session' do
      expect(result).to be_success
      expect(result['session']).to be_persisted
      expect(result['session'].user).to eq(user)
      expect(result['session'].user_agent).to eq(user_agent)
      expect(result['session'].ip_address).to eq(anonymized_ip_address)
    end
  end

  context 'without login' do
    let(:login) { [nil, '    '].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:login]).to be_present
    end
  end

  context 'without password' do
    let(:password) { [nil, ''].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:password]).to be_present
    end
  end

  context 'with unknown username' do
    let(:login) { Factory::User.username }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'with wrong password' do
    let(:password) { Factory::User.password }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'as logged in user' do
    let(:current_user) { user }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
