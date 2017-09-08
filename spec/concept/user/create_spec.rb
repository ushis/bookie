require 'rails_helper'

RSpec.describe User::Create, type: :operation do
  let(:result) { User::Create.(params) }

  let(:params) {
    {
      user: {
        username: username,
        email: email,
        password: password,
        password_confirmation: password_confirmation,
      }
    }
  }

  let(:username) { Factory::User.username }

  let(:email) { Factory::User.email }

  let(:password) { Factory::User.password }

  let(:password_confirmation) { password }

  let(:password_hash) { result['model'].auth_meta_data['password_hash'] }

  it 'successfully saves the new user' do
    expect(result).to be_success
    expect(result['model']).to be_persisted
    expect(result['model'].username).to eq(username)
    expect(result['model'].email).to eq(email)
    expect(BCrypt::Password.new(password_hash)).to eq(password)
  end

  context 'without username' do
    let(:username) { [nil, '    '].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:username]).to be_present
    end
  end

  context 'with invalid username' do
    let(:username) { 'Invalid' }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:username]).to be_present
    end
  end

  context 'with already taken username' do
    let(:username) { Factory::User.create.username }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:username]).to be_present
    end
  end

  context 'without email' do
    let(:email) { [nil, '    '].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:email]).to be_present
    end
  end

  context 'with invalid email' do
    let(:email) { 'invalid' }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:email]).to be_present
    end
  end

  context 'with already taken email' do
    let(:email) { Factory::User.create.email }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:email]).to be_present
    end
  end

  context 'without password' do
    let(:password) { [nil, ''].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:password]).to be_present
    end
  end

  context 'without password confirmation' do
    let(:password_confirmation) { [nil, '    '].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:password_confirmation]).to be_present
    end
  end

  context 'without wrong password confirmation' do
    let(:password_confirmation) { 'wrong' }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:password_confirmation]).to be_present
    end
  end
end
