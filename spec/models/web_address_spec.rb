require 'rails_helper'

describe WebAddress, type: :model do
  describe '.ready_to_ping' do
    let!(:web_address_1) { create(:web_address, pinged_at: 24.minutes.ago) }
    let!(:web_address_2) { create(:web_address, pinged_at: nil) }
    let!(:web_address_3) { create(:web_address, pinged_at: 6.minutes.ago) }

    before do
      create(:web_address, pinged_at: 1.minutes.ago)
      create(:web_address, pinged_at: 4.minutes.ago)
    end

    it 'returns only ready to ping web addresses' do
      expect(described_class.ready_to_ping).to match([web_address_1, web_address_2, web_address_3])
    end
  end

  describe '#set_ping_result!' do
    subject { web_address.set_ping_result!(http_status_code) }

    let(:web_address) { create(:web_address) }
    let(:date_time) { DateTime.parse('2020-05-07 11:05:30') }

    before { allow(DateTime).to receive(:current).and_return(date_time) }

    context 'if the http status code is 5xx' do
      let(:http_status_code) { 500 }

      it 'sets the http status code' do
        expect { subject }.to change { web_address.http_status_code }.to(500)
      end

      it 'sets the status' do
        expect { subject }.to change { web_address.status }.to('down')
      end

      it 'sets the pinging time' do
        expect { subject }.to change { web_address.pinged_at }.to(date_time)
      end

      it 'notifies the users' do
        expect { subject }.to enqueue_job(WebAddresses::UsersNotificationJob).with(web_address.id)
      end

      it 'sets the notification sent flag to true' do
        expect { subject }.to change { web_address.notification_sent }.to(true)
      end

      context 'if the notification sent flag was set to true' do
        before { web_address.notification_sent = true }

        it 'does not change the flag' do
          expect { subject }.not_to change { web_address.notification_sent }.from(true)
        end

        it 'does not notify the users' do
          expect { subject }.not_to enqueue_job(WebAddresses::UsersNotificationJob)
        end
      end
    end

    context 'if the http status code is between 2xx and 4xx' do
      let(:http_status_code) { 301 }

      it 'sets the http status code' do
        expect { subject }.to change { web_address.http_status_code }.to(301)
      end

      it 'sets the status' do
        expect { subject }.to change { web_address.status }.to('up')
      end

      it 'sets the pinging time' do
        expect { subject }.to change { web_address.pinged_at }.to(date_time)
      end

      it 'does not notify the users' do
        expect { subject }.not_to enqueue_job(WebAddresses::UsersNotificationJob)
      end

      it 'does not set the notification sent flag to true' do
        expect { subject }.not_to change { web_address.notification_sent }.from(false)
      end

      context 'if the notification sent flag was set to true' do
        before { web_address.notification_sent = true }

        it 'sets the notification sent flag to false' do
          expect { subject }.to change { web_address.notification_sent }.to(false)
        end
      end
    end
  end

  describe 'mark_as_faulty!' do
    subject { web_address.mark_as_faulty! }

    let(:web_address) { create(:web_address) }
    let(:date_time) { DateTime.parse('2020-05-07 11:05:30') }

    before { allow(DateTime).to receive(:current).and_return(date_time) }

    it 'sets the error status' do
      expect { subject }.to change { web_address.status }.to('error')
    end

    it 'sets the pinging time' do
      expect { subject }.to change { web_address.pinged_at }.to(date_time)
    end

    it 'notifies the users' do
      expect { subject }.to enqueue_job(WebAddresses::UsersNotificationJob).with(web_address.id)
    end

    it 'sets the notification sent flag to true' do
      expect { subject }.to change { web_address.notification_sent }.to(true)
    end

    context 'if the notification sent flag was set to true' do
      before { web_address.notification_sent = true }

      it 'does not change the flag' do
        expect { subject }.not_to change { web_address.notification_sent }.from(true)
      end

      it 'does not notify the users' do
        expect { subject }.not_to enqueue_job(WebAddresses::UsersNotificationJob)
      end
    end
  end
end
