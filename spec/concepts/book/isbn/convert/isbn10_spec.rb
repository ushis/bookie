require 'rails_helper'

RSpec.describe Book::ISBN::Convert::ISBN10, type: :operation do
  let(:result) { Book::ISBN::Convert::ISBN10.(nil, isbn: isbn) }

  let(:isbn) { '3453146972' }

  it 'successfully calculates a 13 digit isbn' do
    expect(result).to be_success
    expect(result['isbn_13']).to eq('9783453146976')
  end

  context 'with invalid isbn' do
    let(:isbn) { 'invalid' }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
