require 'rails_helper'

RSpec.describe User::Find, type: :operation do
  let(:result) { User::Find.(params) }

  let(:params) { {id: id} }

  let(:id) { user.id }

  let(:user) { Factory::User.create }

  it 'successfully finds the user' do
    expect(result).to be_success
    expect(result['model']).to eq(user)
  end

  context 'with invalid id' do
    let(:id) { [0, :invalid].sample }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
