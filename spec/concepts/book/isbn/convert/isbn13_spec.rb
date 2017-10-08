require 'rails_helper'

RSpec.describe Book::ISBN::Convert::ISBN13, type: :operation do
  let(:result) { Book::ISBN::Convert::ISBN13.(nil, isbn: isbn) }

  let(:isbn) { '9783453146976' }

  it 'successfully calculates a 10 digit isbn' do
    expect(result).to be_success
    expect(result['isbn_10']).to eq('3453146972')
  end

  context 'with unconvertable isbn' do
    let(:isbn) { '9993453146979' }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'with invalid isbn' do
    let(:isbn) { '978invalid' }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
