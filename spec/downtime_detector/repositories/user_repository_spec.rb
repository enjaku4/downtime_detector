RSpec.describe UserRepository do
  describe '#find_by_nickname' do
    subject { described_class.new.find_by_nickname('foobar') }

    context 'if there are no records with such nickname' do
      it { is_expected.to be_nil }
    end

    context 'if there is a record with such nickname' do
      let!(:user) { Fabricate(:user, nickname: 'foobar') }

      it { is_expected.to eq(user) }
    end
  end
end
