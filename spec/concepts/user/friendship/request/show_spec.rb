require 'rails_helper'

RSpec.describe User::Friendship::Request::Show, type: :operation do
  let(:result) { User::Friendship::Request::Show.(params, dependencies) }

  let(:params) { {id: id} }

  let(:id) { friendship_request.id }

  let(:friendship_request) {
    Factory::FriendshipRequest.create.received_friendship_requests.first
  }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { [receiver, sender].sample }

  let(:receiver) { friendship_request.receiver }

  let(:sender) { friendship_request.sender }

  it 'successfully finds the friendship request' do
    expect(result).to be_success
    expect(result['model']).to eq(friendship_request)
  end

  context 'with invalid id' do
    let(:id) { 0 }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'as stranger' do
    let(:current_user) { Factory::User.create }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
