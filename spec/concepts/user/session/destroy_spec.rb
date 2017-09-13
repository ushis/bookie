require 'rails_helper'

RSpec.describe User::Session::Destroy, type: :operation do
  let(:result) { User::Session::Destroy.(params, dependencies) }

  let(:params) { {id: id} }

  let(:id) { session.id }

  let(:session) { Factory::Session.create }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { session.user }

  it 'successfully destroys the session' do
    expect(result).to be_success
    expect { session.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  context 'with unknown id' do
    let(:id) { 0 }

    it 'fails and does not destroy the session' do
      expect(result).to be_failure
      expect { session.reload }.to_not raise_error
    end
  end

  context 'with id of another users session' do
    let(:id) { Factory::Session.create.id }

    it 'fails and does not destroy the session' do
      expect(result).to be_failure
      expect { session.reload }.to_not raise_error
    end
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails and does not destroy the session' do
      expect(result).to be_failure
      expect { session.reload }.to_not raise_error
    end
  end
end
