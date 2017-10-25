require 'rails_helper'

RSpec.describe User::Friendship::Request::Comment, type: :operation do
  let(:result) { User::Friendship::Request::Comment.(params, dependencies) }

  let(:params) {
    {
      id: id,
      comment: {comment: message},
    }
  }

  let(:id) { friendship_request.id }

  let(:friendship_request) {
    Factory::FriendshipRequest.create.received_friendship_requests.first
  }

  let(:message) { Faker::Lorem.paragraph }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { [receiver, sender].sample }

  let(:receiver) { friendship_request.receiver }

  let(:sender) { friendship_request.sender }

  it 'successfully creates a new comment on the friendship request' do
    expect(result).to be_success
    expect(result['model']).to eq(friendship_request)
    expect(result['model'].state).to eq('open')

    result['contract.comment'].model.tap do |comment|
      expect(comment).to be_persisted
      expect(comment.comment).to eq(message)
      expect(comment.commentable).to eq(friendship_request)
      expect(comment.author).to eq(current_user)
    end
  end

  context 'with blank message' do
    let(:message) { '  ' }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.comment'].errors[:comment]).to be_present
    end
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

  context 'when friendship request is already accepted' do
    before {
      User::Friendship::Request::Accept.({id: id}, {current_user: receiver})
    }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'when friendship request is already declined' do
    before {
      User::Friendship::Request::Comment.({
        id: id,
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

  context 'when comment_and_decline flag is set' do
    let(:params) {
      {
        id: id,
        comment: {comment: message},
        comment_and_decline: true,
      }
    }

    let(:current_user) { receiver }

    it 'successfully creates a new comment and declines the friendship request' do
      expect(result).to be_success
      expect(result['model']).to eq(friendship_request)
      expect(result['model'].state).to eq('declined')

      result['contract.comment'].model.tap do |comment|
        expect(comment).to be_persisted
        expect(comment.comment).to eq(message)
        expect(comment.commentable).to eq(friendship_request)
        expect(comment.author).to eq(current_user)
      end
    end

    context 'with blank message' do
      let(:message) { '  ' }

      it 'fails with an error' do
        expect(result).to be_failure
        expect(result['contract.comment'].errors[:comment]).to be_present
      end
    end

    context 'as sender' do
      let(:current_user) { sender }

      it 'fails' do
        expect(result).to be_failure
      end
    end
  end
end
