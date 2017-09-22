require 'rails_helper'

RSpec.describe Book::Cover::ISBN::Lookup do
  let(:result) { Book::Cover::ISBN::Lookup.(nil, isbn: isbn) }

  let(:isbn) { Factory::Book.isbn }

  before { NetStub::BigBookSearch.stub_request(isbn, response) }

  let(:response) { Array.new(3) { |_| Faker::Internet.url } }

  it 'successfully finds the first url' do
    expect(result).to be_success
    expect(result['url']).to eq(response.first)
  end

  context 'when nothing was found' do
    let(:response) { [] }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
