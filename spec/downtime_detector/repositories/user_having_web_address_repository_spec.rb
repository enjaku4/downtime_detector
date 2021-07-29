RSpec.describe UserHavingWebAddressRepository do
  describe '#exists?' do
    subject { described_class.new.exists?(user_id: user.id, web_address_id: web_address.id) }

    let(:user) { Fabricate(:user) }
    let(:web_address) { Fabricate(:web_address) }

    context 'if there is no such record' do
      it { is_expected.to be false }
    end

    context 'if there is a record' do
      before { described_class.new.create(user_id: user.id, web_address_id: web_address.id) }

      it { is_expected.to be true }
    end
  end

  describe '#delete_association' do
    subject { described_class.new.delete_association(user_id: user.id, web_address_id: web_address.id) }

    let(:user) { Fabricate(:user) }
    let(:web_address) { Fabricate(:web_address) }

    before { described_class.new.create(user_id: user.id, web_address_id: web_address.id) }

    it 'deletes the association' do
      expect { subject }
        .to change { described_class.new.exists?(user_id: user.id, web_address_id: web_address.id) }
        .from(true).to(false)
    end
  end
end
