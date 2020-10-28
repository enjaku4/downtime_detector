require 'rails_helper'

describe WebAddresses::PingDelegationJob, type: :job do
  subject { described_class.perform_now }

  let!(:web_address_1) { create(:web_address, pinged_at: 17.minutes.ago) }
  let!(:web_address_2) { create(:web_address, pinged_at: nil) }
  let!(:web_address_3) { create(:web_address, pinged_at: 9.minutes.ago) }

  before do
    create(:web_address, pinged_at: 3.minutes.ago)
    create(:web_address, pinged_at: 2.minutes.ago)
  end

  it 'enqueues a ping job for web_address_1' do
    expect { subject }.to enqueue_job(WebAddresses::PingJob).once.with(666)
  end

  it 'enqueues a ping job for web_address_2' do
    expect { subject }.to enqueue_job(WebAddresses::PingJob).once.with(web_address_2.id)
  end

  it 'enqueues a ping job for web_address_3' do
    expect { subject }.to enqueue_job(WebAddresses::PingJob).once.with(web_address_3.id)
  end

  it 'enqueues only 3 jobs' do
    expect { subject }.to enqueue_job(WebAddresses::PingJob).exactly(3).times
  end
end
