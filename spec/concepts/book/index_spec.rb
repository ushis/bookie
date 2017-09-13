require 'rails_helper'

RSpec.describe Book::Index, type: :operation do
  let(:result) { Book::Index.(params) }

  let(:params) { {} }

  let!(:books) { 3.times.map { |_| Factory::Book.create } }

  it 'successfully fetches all books' do
    expect(result).to be_success
    expect(result['books']).to match_array(books)
  end

  context 'when q param is present' do
    let(:params) { {q: q} }

    let(:sample) { books.sample }

    context 'and q is the full isbn of a sample' do
      let(:q) { sample.isbn }

      it 'successfully fetches the sample' do
        expect(result).to be_success
        expect(result['books']).to match_array([sample])
      end
    end

    context 'and q is a partial isbn of a sample' do
      let(:q) { sample.isbn[1..-2] }

      it 'successfully fetches the sample' do
        expect(result).to be_success
        expect(result['books']).to match_array([sample])
      end
    end

    context 'and q is a full title of a sample' do
      let(:q) { sample.title }

      it 'successfully fetches the sample' do
        expect(result).to be_success
        expect(result['books']).to match_array([sample])
      end
    end

    context 'and q is a partial title of a sample' do
      let(:q) { sample.title[1..-2] }

      it 'successfully fetches the sample' do
        expect(result).to be_success
        expect(result['books']).to match_array([sample])
      end
    end

    context 'and q is a full author of a sample' do
      let(:q) { sample.authors }

      it 'successfully fetches the sample' do
        expect(result).to be_success
        expect(result['books']).to match_array([sample])
      end
    end

    context 'and q is a partial author of a sample' do
      let(:q) { sample.authors[1..-2] }

      it 'successfully fetches the sample' do
        expect(result).to be_success
        expect(result['books']).to match_array([sample])
      end
    end

    context 'and q is random noise' do
      let(:q) { books.map(&:isbn).join }

      it 'successfully fetches nothing' do
        expect(result).to be_success
        expect(result['books']).to be_empty
      end
    end
  end
end
