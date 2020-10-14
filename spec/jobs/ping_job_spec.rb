require 'rails_helper'

describe WebAddresses::PingJob, type: :job do
  subject { described_class.perform_now(web_address.id) }

  let(:web_address) { create(:web_address) }

  before { allow(WebAddress).to receive(:find).with(web_address.id).and_return(web_address) }

  context 'pinging is successful' do
    let(:faraday_response_double) { double(status: 200) }

    before { allow(Faraday).to receive(:get).with(web_address.url).and_return(faraday_response_double) }

    it 'updates the pinging result' do
      expect(web_address).to receive(:set_ping_result!).with(200)
      subject
    end
  end

  context 'pinging is unsuccessful' do
    before { allow(Faraday).to receive(:get).with(web_address.url).and_raise(Faraday::TimeoutError) }

    it 'marks the web address as faulty' do
      expect(web_address).to receive(:mark_as_faulty!)
      subject
    end
  end
end
