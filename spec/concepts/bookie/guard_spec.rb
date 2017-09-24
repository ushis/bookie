require 'rails_helper'

RSpec.describe Bookie::Guard do
  describe '.call' do
    subject { Bookie::Guard.(args) }

    let(:args) { {current_user: nil, model: nil} }

    it { is_expected.to eq(false) }

    context 'without a model argument' do
      let(:args) { {current_user: nil} }

      it { is_expected.to eq(false) }
    end
  end

  describe '#user' do
    subject { Bookie::Guard.new(user: user, model: model).user }

    let(:user) { [:a, :b, :c].sample }

    let(:model) { nil }

    it { is_expected.to eq(user) }
  end

  describe '#model' do
    subject { Bookie::Guard.new(user: user, model: model).model }

    let(:user) { nil }

    let(:model) { [:a, :b, :c].sample }

    it { is_expected.to eq(model) }
  end

  describe '#call' do
    subject { Bookie::Guard.new(user: user, model: model).() }

    let(:user) { nil }

    let(:model) { nil }

    it { is_expected.to eq(false) }
  end
end
