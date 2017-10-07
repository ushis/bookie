require 'rails_helper'

RSpec.describe User::Settings::Account::Destroy, type: :operation do
  let(:result) { User::Settings::Account::Destroy.(params, dependencies) }

  let(:params) {
    {
      user: {
        current_password: current_password,
      },
    }
  }

  let(:current_password) { current_user_factory.password }

  let(:current_user_factory) { Factory::User.new }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { current_user_factory.create }

  it 'successfully destroys the user and its avatar' do
    expect(result).to be_success
    expect { current_user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect { current_user.avatar.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  context 'with incorrect current password' do
    let(:current_password) { Factory::User.password }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.destroy'].errors[:current_password]).to be_present
    end
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
