require 'rails_helper'

RSpec.describe User::SignOut, type: :operation do
  let(:result) { User::SignOut.({}, dependencies) }

  let(:dependencies) {
    {
      current_user: current_user,
      current_session: current_session,
    }
  }

  let(:current_user) { current_session.user }

  let(:current_session) { Factory::Session.create }

  it 'successfully destroys the current session' do
    expect(result).to be_success
    expect { current_session.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    let(:current_session) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
