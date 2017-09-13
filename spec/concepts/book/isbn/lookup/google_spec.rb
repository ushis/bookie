require 'rails_helper'

RSpec.describe Book::ISBN::Lookup::Google do
  let(:result) { Book::ISBN::Lookup::Google.(nil, isbn: isbn) }

  let(:isbn) { Factory::Book.isbn }

  before { NetStub::GoogleBooks.stub_request(isbn, response) }

  let(:response) {
    [{
      isbn: response_isbn,
      title: response_title,
      authors: response_authors,
    }, {
      isbn: Factory::Book.isbn,
      title: Factory::Book.title,
      authors: Factory::Book.authors,
    }, {
      isbn: Factory::Book.isbn,
      title: Factory::Book.title,
      authors: Factory::Book.authors,
    }].shuffle
  }

  let(:response_isbn) { isbn }

  let(:response_title) { Factory::Book.title }

  let(:response_authors) { [Factory::Book.authors, Factory::Book.authors] }

  it 'successfully finds the correct attributes' do
    expect(result).to be_success
    expect(result['attributes'][:isbn]).to eq(isbn)
    expect(result['attributes'][:title]).to eq(response_title)
    expect(result['attributes'][:authors]).to eq(response_authors.join(', '))
  end

  context 'when no isbn matches' do
    let(:response_isbn) { Factory::Book.isbn }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'when nothing was found' do
    let(:response) { [] }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
