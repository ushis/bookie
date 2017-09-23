require 'rails_helper'

RSpec.describe Bookie::Search::Results do
  let(:results) { Bookie::Search::Results.new(query, response) }

  let(:query) {
    Bookie::Search::Query.new(nil, {
      index: nil,
      query: nil,
      page: page,
      per: per,
    })
  }

  let(:page) { rand(1..100) }

  let(:per) { rand(1..10) }

  let(:response) {
    {
      'hits' => {
        'total' => total,
        'hits' => ids.map { |id|
          {
            '_id' => id.to_s,
            '_score' => rand,
          }
        },
      },
    }
  }

  let(:total) { rand(1..1000) }

  let(:ids) { Array.new(rand(11..20)) { |_| rand(1..200) } }

  describe '#ids' do
    subject { results.ids }

    it { is_expected.to eq(ids) }
  end

  describe '#total_count' do
    subject { results.total_count }

    it { is_expected.to eq(total) }
  end

  describe '#total_pages' do
    subject { results.total_pages }

    let(:total) { 10 }

    let(:per) { 4 }

    it { is_expected.to eq(3) }
  end

  describe '#current_page' do
    subject { results.current_page }

    it { is_expected.to eq(page) }
  end

  describe '#next_page' do
    subject { results.next_page }

    let(:page) { rand(1..5) }

    let(:per) { 10 }

    let(:total) { 51 }

    it { is_expected.to eq(page + 1) }

    context 'when it is the last page' do
      let(:page) { 6 }

      it { is_expected.to eq(nil) }
    end

    context 'when it is out of range' do
      let(:page) { rand(7..10) }

      it { is_expected.to eq(nil) }
    end
  end

  describe '#prev_page' do
    subject { results.prev_page }

    let(:page) { rand(2..5) }

    let(:per) { 10 }

    let(:total) { 51 }

    it { is_expected.to eq(page - 1) }

    context 'when it is the first page' do
      let(:page) { 1 }

      it { is_expected.to eq(nil) }
    end

    context 'when it is out of range' do
      let(:page) { rand(7..10) }

      it { is_expected.to eq(nil) }
    end
  end

  describe '#first_page?' do
    subject { results.first_page? }

    let(:page) { rand(2..5) }

    it { is_expected.to eq(false) }

    context 'when it is th first page' do
      let(:page) { 1 }

      it { is_expected.to eq(true) }
    end
  end

  describe '#last_page?' do
    subject { results.last_page? }

    let(:page) { rand(1..5) }

    let(:per) { 10 }

    let(:total) { 51 }

    it { is_expected.to eq(false) }

    context 'when it is the last page' do
      let(:page) { 6 }

      it { is_expected.to eq(true) }
    end
  end

  describe '#out_of_range?' do
    subject { results.out_of_range? }

    let(:page) { rand(1..6) }

    let(:per) { 10 }

    let(:total) { 51 }

    it { is_expected.to eq(false) }

    context 'when it is out of range' do
      let(:page) { rand(7..10) }

      it { is_expected.to eq(true) }
    end
  end
end
