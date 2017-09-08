require 'rails_helper'

RSpec.describe Book::ISBN::Normalize do
  let(:result) { Book::ISBN::Normalize.({}, {isbn: isbn}) }

  let(:isbn) { '9780131103627' }

  it 'successfully does nothing' do
    expect(result).to be_success
    expect(result['isbn']).to eq(isbn)
  end

  context 'with dashes' do
    let(:isbn) { '978-0-131-10362-7' }

    it 'successfully removes the dashes' do
      expect(result).to be_success
      expect(result['isbn']).to eq('9780131103627')
    end
  end

  context 'with 10 digits' do
    let(:isbn) { '0131103628' }

    it 'successfully converts it to a 13 digit isbn' do
      expect(result).to be_success
      expect(result['isbn']).to eq('9780131103627')
    end

    context 'and dashes' do
      let(:isbn) { '0-13-110362-8' }

      it 'successfully converts it to a 13 digit isbn' do
        expect(result).to be_success
        expect(result['isbn']).to eq('9780131103627')
      end
    end

    context 'and an X digit' do
      let(:isbn) { '022000000X' }

      it 'successfully converts it to a 13 digit isbn' do
        expect(result).to be_success
        expect(result['isbn']).to eq('9780220000004')
      end
    end
  end
end
