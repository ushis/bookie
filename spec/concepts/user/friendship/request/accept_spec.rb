require 'rails_helper'

RSpec.describe User::Friendship::Request::Accept do
  let(:result) { User::Friendship::Request::Accept.(params, dependencies) }

  let(:params) { {id: id} }

  let(:id) { friendship_request.id }

  let(:friendship_request) {
    Factory::FriendshipRequest.create({
      id: receiver.id,
    }, {
      current_user: sender,
    }).received_friendship_requests.find_by(sender: sender)
  }

  let(:receiver) { Factory::User.create }

  let(:sender) { Factory::User.create }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { receiver }

  it 'successfully accepts the friendship request and creates a friendship' do
    expect(result).to be_success
    expect(result['model'].state).to eq('accepted')
    expect(receiver.friends).to include(sender)
    expect(sender.friends).to include(receiver)
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

  context 'as sender' do
    let(:current_user) { sender }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'when it already is accepted' do
    before { User::Friendship::Request::Accept.(params, dependencies) }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'when it already is declined' do
    before {
      User::Friendship::Request::Comment.({
        id: friendship_request.id,
        comment: {comment: Faker::Lorem.paragraph},
        comment_and_decline: true,
      }, {
        current_user: receiver,
      })
    }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
