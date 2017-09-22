require 'rails_helper'

RSpec.describe Book::Create, type: :operation do
  let(:result) { Book::Create.(params, dependencies) }

  let(:params) {
    {
      book: {
        isbn: isbn,
        title: title,
        authors: authors,
      },
    }
  }

  let(:isbn) { Factory::Book.isbn }

  let(:title) { Factory::Book.title }

  let(:authors) { Factory::Book.authors }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { Factory::User.create }

  before { NetStub::Image.stub_request(cover_urls.first) }

  let(:cover_urls) { NetStub::BigBookSearch.stub_request(isbn_normalized) }

  let(:isbn_normalized) { isbn }

  it 'successfully creates a book with a cover' do
    expect(result).to be_success
    expect(result['model']).to be_persisted
    expect(result['model'].isbn).to eq(isbn)
    expect(result['model'].title).to eq(title)
    expect(result['model'].authors).to eq(authors)
  end

  context 'with 10 digit isbn' do
    let(:isbn) { '0465002048' }

    let(:isbn_normalized) { '9780465002047' }

    it 'successfully creates a book and normalizes the isbn' do
      expect(result).to be_success
      expect(result['model']).to be_persisted
      expect(result['model'].isbn).to eq(isbn_normalized)
    end
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'with empty isbn' do
    let(:isbn) { nil }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:isbn]).to be_present
    end
  end

  context 'with invalid isbn' do
    let(:isbn) { ['invalid', '0465202048', '9780465012047'].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:isbn]).to be_present
    end
  end

  context 'with already taken isbn' do
    let(:isbn) { Factory::Book.create.isbn }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:isbn]).to be_present
    end
  end

  context 'without title' do
    let(:title) { [nil, '     '].sample }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:title]).to be_present
    end
  end

  context 'with too long title' do
    let(:title) { Faker::Lorem.characters(256) }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:title]).to be_present
    end
  end

  context 'with too long authors' do
    let(:authors) { Faker::Lorem.characters(256) }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.default'].errors[:authors]).to be_present
    end
  end
end
