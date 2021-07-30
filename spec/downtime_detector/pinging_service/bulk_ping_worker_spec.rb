require 'sidekiq/testing'

RSpec.describe PingingService::BulkPingWorker do
  subject { described_class.new.perform }

  let!(:web_address_not_pinged) { Fabricate(:web_address) }
  let!(:web_address_pinged_long_ago) { Fabricate(:web_address, pinged_at: Chronic.parse('6 minutes ago')) }

  before do
    Fabricate(:web_address, pinged_at: Chronic.parse('4 minutes ago'))
    Fabricate(:web_address, pinged_at: Chronic.parse('1 minute ago'))
  end

  it 'enqueues exactly 2 jobs' do
    Sidekiq::Testing.fake! do
      subject
      expect(PingingService::PingWorker.jobs.flat_map { |job| job['args'] })
        .to contain_exactly(web_address_not_pinged.id, web_address_pinged_long_ago.id)
    end
  end
end