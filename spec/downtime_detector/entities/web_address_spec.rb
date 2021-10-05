RSpec.describe WebAddress do
  describe '#faulty?' do
    subject { web_address.faulty? }

    let(:web_address) { Fabricate(:web_address, status: status) }

    context 'if status is unknown' do
      let(:status) { 'unknown' }

      it { is_expected.to be false }
    end

    context 'if status is up' do
      let(:status) { 'up' }

      it { is_expected.to be false }
    end

    context 'if status is down' do
      let(:status) { 'down' }

      it { is_expected.to be true }
    end

    context 'if status is error' do
      let(:status) { 'error' }

      it { is_expected.to be true }
    end
  end
end
