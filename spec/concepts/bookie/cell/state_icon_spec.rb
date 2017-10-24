require 'rails_helper'

RSpec.describe Bookie::Cell::StateIcon, type: :cell do
  controller ApplicationController

  let(:cell) { concept('bookie/cell/state_icon', state).() }

  context 'when state is "open"' do
    let(:state) { 'open' }

    it 'renders an open state icon' do
      expect(cell).to have_selector('.octicon-issue-opened.has-text-success')
    end
  end

  context 'when state is "accepted"' do
    let(:state) { 'accepted' }

    it 'renders an accepted state icon' do
      expect(cell).to have_selector('.octicon-issue-closed.has-text-info')
    end
  end

  context 'when state is "declined"' do
    let(:state) { 'declined' }

    it 'renders a declined state icon' do
      expect(cell).to have_selector('.octicon-issue-opened.has-text-danger')
    end
  end
end
