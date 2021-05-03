require 'rails_helper'

describe WebAddresses::PingJob, type: :job do
  subject { described_class.perform_now(web_address.id) }

  let(:web_address) { create(:web_address) }

  before { allow(WebAddress).to receive(:find).with(web_address.id).and_return(web_address) }

  context 'if pinging is successful' do
    let(:faraday_response_double) { double }

    before { allow(Faraday).to receive(:get).with(web_address.url).and_return(faraday_response_double) }

    it 'processes the response' do
      expect(WebAddresses::Results::ResponseProcessing).to receive_message_chain(:new, :run)
        .with(web_address, response: faraday_response_double).with(no_args)
      subject
    end
  end

  context 'if pinging is unsuccessful' do
    before { allow(Faraday).to receive(:get).with(web_address.url).and_raise(Faraday::TimeoutError) }

    it 'processes the error' do
      expect(WebAddresses::Results::ErrorProcessing).to receive_message_chain(:new, :run)
        .with(web_address, exception: instance_of(Faraday::TimeoutError)).with(no_args)
      subject
    end
  end
end
