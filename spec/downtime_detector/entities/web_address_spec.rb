RSpec.describe WebAddress do
  describe '#faulty?' do
    subject { web_address.faulty? }

    let(:web_address) { Fabricate.build(:web_address, status: status) }

    context 'if status unknown' do
      let(:status) { 'unknown' }

      it { is_expected.to be false }
    end

    context 'if status up' do
      let(:status) { 'up' }

      it { is_expected.to be false }
    end

    context 'if status down' do
      let(:status) { 'down' }

      it { is_expected.to be true }
    end

    context 'if status error' do
      let(:status) { 'error' }

      it { is_expected.to be true }
    end
  end
end