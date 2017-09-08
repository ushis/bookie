require 'rails_helper'

RSpec.describe Book::ISBN::Validate, type: :operation do
  let(:result) { Book::ISBN::Validate.({}, {isbn: isbn}) }

  let(:isbn) { '9780131103627' }

  it 'is successfull' do
    expect(result).to be_success
  end

  context 'with dashes' do
    let(:isbn) { '978-0-131-10362-7' }

    it 'is successfull' do
      expect(result).to be_success
    end
  end

  context 'with 10 digits' do
    let(:isbn) { '0131103628' }

    it 'is successfull' do
      expect(result).to be_success
    end

    context 'and dashes' do
      let(:isbn) { '0-13-110362-8' }

      it 'is successfull' do
        expect(result).to be_success
      end
    end

    context 'and an X digit' do
      let(:isbn) { '022000000X' }

      it 'is successfull' do
        expect(result).to be_success
      end
    end
  end

  context 'too short' do
    let(:isbn) { '013110366' }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'too long' do
    let(:isbn) { '97801311036270' }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'with characters' do
    let(:isbn) { 'invalid__isbn' }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
