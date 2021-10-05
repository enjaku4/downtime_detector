require_relative 'base_processor'

describe PingingService::Results::ErrorProcessor do
  subject { described_class.new(web_address, exception: exception).call }

  let(:web_address) { Fabricate(:web_address, http_status_code: 200, status: status) }
  let(:exception) { Faraday::TimeoutError.new }

  context "if the web address\'s status was faulty" do
    let(:status) { 'down' }

    it_behaves_like 'pinging result processor', nil, 'error', 'timeout'

    it 'does not send any notifications' do
      expect(PingingService::UsersNotificationWorker).not_to receive(:perform_async)
      subject
    end
  end

  context 'if the web address\'s status was not faulty' do
    let(:status) { 'unknown' }

    it_behaves_like 'pinging result processor', nil, 'error', 'timeout'

    it 'sends notifications' do
      expect(PingingService::UsersNotificationWorker).to receive(:perform_async).with(web_address.id)
      subject
    end
  end
end
