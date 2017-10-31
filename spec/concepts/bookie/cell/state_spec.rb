require 'rails_helper'

RSpec.describe Bookie::Cell::State, type: :cell do
  controller ApplicationController

  let(:cell) { concept('bookie/cell/state', state).() }

  context 'when state is "open"' do
    let(:state) { 'open' }

    it 'renders an open state tag' do
      expect(cell).to have_selector('.tag.is-success .octicon-issue-opened')
      expect(cell).to have_content('Open')
    end
  end

  context 'when state is "accepted"' do
    let(:state) { 'accepted' }

    it 'renders an accepted state tag' do
      expect(cell).to have_selector('.tag.is-info .octicon-issue-closed')
      expect(cell).to have_content('Accepted')
    end
  end

  context 'when state is "declined"' do
    let(:state) { 'declined' }

    it 'renders a declined state tag' do
      expect(cell).to have_selector('.tag.is-danger .octicon-issue-opened')
      expect(cell).to have_content('Declined')
    end
  end
end
