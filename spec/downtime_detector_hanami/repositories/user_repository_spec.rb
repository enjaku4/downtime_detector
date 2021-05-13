RSpec.describe UserRepository, type: :repository do
  describe '#find_by_nickname' do
    subject { described_class.new.find_by_nickname('foobar') }

    context 'if there are no records at all' do
      it { is_expected.to be_nil }
    end

    context 'if there are records, but with different names' do
      before do
        User.create(nickname: 'barbaz', password: 'secret')
        User.create(nickname: 'bazbar', password: 'secret')
      end

      it { is_expected.to be_nil }
    end

    context 'if there is only one record with the needed name' do
      let!(:user) { User.create(nickname: 'foobar', password: 'secret') }

      it { is_expected.to eq(user) }
    end

    context 'if there are many records, yet there is one with the needed name' do
      let!(:user) { User.create(nickname: 'foobar', password: 'secret') }

      before do
        User.create(nickname: 'barbaz', password: 'secret')
        User.create(nickname: 'bazbar', password: 'secret')
      end

      it { is_expected.to eq(user) }
    end
  end
end
