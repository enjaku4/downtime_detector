RSpec.describe PingingService::PingWorker do
  subject { described_class.new.perform(web_address.id) }

  let(:web_address) { Fabricate(:web_address) }

  context 'if pinging is successful' do
    let(:response) { double }
    let(:processor) { double }

    before do
      allow(Faraday).to receive(:get).with(web_address.url).and_return(response)
      allow(PingingService::Results::ResponseProcessor).to receive(:new).with(web_address, response: response).and_return(processor)
      allow(processor).to receive(:call)
    end

    it 'processes the response' do
      subject
      expect(processor).to have_received(:call)
    end
  end

  context 'if pinging is unsuccessful' do
    let(:error) { Faraday::TimeoutError }
    let(:processor) { double }

    before do
      allow(Faraday).to receive(:get).with(web_address.url).and_raise(error)
      allow(PingingService::Results::ErrorProcessor).to receive(:new).with(web_address, exception: error).and_return(processor)
      allow(processor).to receive(:call)
    end

    it 'processes the error' do
      subject
      expect(processor).to have_received(:call)
    end
  end
end