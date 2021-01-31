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

  describe '#faulty?' do
    subject { web_address.faulty? }

    let(:web_address) { build(:web_address, status: status) }

    context "when the web address\'s status is down" do
      let(:status) { :down }

      it { is_expected.to be true }
    end

    context "when the web address\'s status is error" do
      let(:status) { :error }

      it { is_expected.to be true }
    end

    context "when the web address\'s status is up" do
      let(:status) { :up }

      it { is_expected.to be false }
    end

    context "when the web address\'s status is unknown" do
      let(:status) { :unknown }

      it { is_expected.to be false }
    end
  end

  describe '#update_ping_time!' do
    let(:web_address) { create(:web_address) }
    let(:datetime) { DateTime.parse('2020-12-15T17:19:13+00:00') }

    before { allow(DateTime).to receive(:current).and_return(datetime) }

    it "changes the web address\'s pinged_at to DateTime#current" do
      expect { web_address.update_ping_time! }.to change { web_address.pinged_at }.to(datetime)
    end
  end

  describe '#reset_notifications!' do
    let(:web_address) { create(:web_address, notifications_sent: notifications_sent) }

    context 'if the notifications_sent flag was true' do
      let(:notifications_sent) { true }

      it 'changes the notifications_sent flag to false' do
        expect { web_address.reset_notifications! }.to change { web_address.notifications_sent }.from(true).to(false)
      end
    end

    context 'if the notifications_sent flag was false' do
      let(:notifications_sent) { false }

      it 'changes nothing' do
        expect { subject }.not_to change { web_address.notifications_sent }.from(false)
      end
    end
  end
end
