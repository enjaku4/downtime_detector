require_relative 'base_processor'

describe PingingService::Results::ResponseProcessor do
  subject { described_class.new(web_address, response: response).call }

  let(:web_address) { Fabricate(:web_address, status: status) }

  [100, 200, 300].each do |status_code|
    context "if the http status code is #{status_code}" do
      let(:response) { Faraday::Response.new(status: status_code, reason_phrase: 'foo') }

      context "if the web address\'s status was faulty" do
        let(:status) { 'error' }

        it_behaves_like 'pinging result processor', status_code, 'up', 'foo'

        it 'sends notifications' do
          expect(PingingService::UsersNotificationWorker).to receive(:perform_async).with(web_address.id)
          subject
        end
      end

      context 'if the web address\'s status was not faulty' do
        let(:status) { 'unknown' }

        it_behaves_like 'pinging result processor', status_code, 'up', 'foo'

        it 'does not send any notifications' do
          expect(PingingService::UsersNotificationWorker).not_to receive(:perform_async)
          subject
        end
      end
    end
  end

  [400, 500].each do |status_code|
    context "if the http status code is #{status_code}" do
      let(:response) { Faraday::Response.new(status: status_code, reason_phrase: 'foo') }

      context "if the web address\'s status was faulty" do
        let(:status) { 'error' }

        it_behaves_like 'pinging result processor', status_code, 'down', 'foo'

        it 'does not send any notifications' do
          expect(PingingService::UsersNotificationWorker).not_to receive(:perform_async)
          subject
        end
      end

      context 'if the web address\'s status was not faulty' do
        let(:status) { 'unknown' }

        it_behaves_like 'pinging result processor', status_code, 'down', 'foo'

        it 'sends notifications' do
          expect(PingingService::UsersNotificationWorker).to receive(:perform_async).with(web_address.id)
          subject
        end
      end
    end
  end
end
