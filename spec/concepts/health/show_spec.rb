require 'rails_helper'

RSpec.describe Health::Show, type: :operation do
  let(:result) { Health::Show.() }

  before {
    allow(Sidekiq::Stats).to \
      receive_message_chain(:new, :processes_size) { sidekiq_processes_size }
  }

  let(:sidekiq_processes_size) { rand(1..10) }

  let(:system_hash) { result['system'].to_h }

  it 'successfully reports healthiness' do
    expect(result).to be_success
    expect(result['system']).to be_healthy

    expect(system_hash).to eq({
      status: 'ok',
      checks: {
        database: 'ok',
        elasticsearch: 'ok',
        s3: 'ok',
        sidekiq: 'ok',
      },
    })
  end

  context 'when the database is down' do
    before { ActiveRecord::Base.remove_connection }

    after { ActiveRecord::Base.establish_connection }

    it 'successfully reports unhealthiness' do
      expect(result).to be_success
      expect(system_hash[:status]).to eq('critical')
      expect(system_hash[:checks][:database]).to match(/\Acritical: .*\z/)
      expect(system_hash[:checks][:elasticsearch]).to eq('ok')
      expect(system_hash[:checks][:s3]).to eq('ok')
      expect(system_hash[:checks][:sidekiq]).to eq('ok')
    end
  end

  context 'when elasticsearch is down' do
    before { allow(Bookie::Search).to receive(:ping) { false } }

    it 'successfully reports unhealthiness' do
      expect(result).to be_success
      expect(system_hash[:status]).to eq('critical')
      expect(system_hash[:checks][:database]).to eq('ok')
      expect(system_hash[:checks][:elasticsearch]).to match(/\Acritical: .*\z/)
      expect(system_hash[:checks][:s3]).to eq('ok')
      expect(system_hash[:checks][:sidekiq]).to eq('ok')
    end
  end

  context 'when s3 bucket does not exist' do
    before { allow(Dragonfly.app.datastore).to receive(:bucket_exists?) { false } }

    it 'successfully reports unhealthiness' do
      expect(result).to be_success
      expect(system_hash[:status]).to eq('critical')
      expect(system_hash[:checks][:database]).to eq('ok')
      expect(system_hash[:checks][:elasticsearch]).to eq('ok')
      expect(system_hash[:checks][:s3]).to match(/\Acritical: .*\z/)
      expect(system_hash[:checks][:sidekiq]).to eq('ok')
    end
  end

  context 'when s3 is down' do
    before {
      allow(Dragonfly.app.datastore).to \
        receive(:bucket_exists?) { raise 'Oh my god, s3 is down!' }
    }

    it 'successfully reports unhealthiness' do
      expect(result).to be_success
      expect(system_hash[:status]).to eq('critical')
      expect(system_hash[:checks][:database]).to eq('ok')
      expect(system_hash[:checks][:elasticsearch]).to eq('ok')
      expect(system_hash[:checks][:s3]).to match(/\Acritical: .*\z/)
      expect(system_hash[:checks][:sidekiq]).to eq('ok')
    end
  end

  context 'when there is no running sidekiq process' do
    let(:sidekiq_processes_size) { 0 }

    it 'successfully reports unhealthiness' do
      expect(result).to be_success
      expect(system_hash[:status]).to eq('critical')
      expect(system_hash[:checks][:database]).to eq('ok')
      expect(system_hash[:checks][:elasticsearch]).to eq('ok')
      expect(system_hash[:checks][:s3]).to eq('ok')
      expect(system_hash[:checks][:sidekiq]).to match(/\Acritical: .*\z/)
    end
  end

  context 'when redis is down' do
    before {
      allow(Sidekiq::Stats).to \
        receive(:new) { raise 'Oh my god, redis is down' }
    }

    it 'successfully reports unhealthiness' do
      expect(result).to be_success
      expect(system_hash[:status]).to eq('critical')
      expect(system_hash[:checks][:database]).to eq('ok')
      expect(system_hash[:checks][:elasticsearch]).to eq('ok')
      expect(system_hash[:checks][:s3]).to eq('ok')
      expect(system_hash[:checks][:sidekiq]).to match(/\Acritical: .*\z/)
    end
  end
end
