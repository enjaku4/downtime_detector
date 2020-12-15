require 'rails_helper'

describe WebAddresses::DeletionInteraction do
  subject { described_class.run(web_address: web_address, user: user) }

  let(:user) { create(:user) }
  let(:web_address) { create(:web_address) }

  before do
    create(:problem, web_address: web_address)
    user.web_addresses << web_address
  end

  describe '#execute' do
    context 'if the web address is linked with a single user' do
      it 'unlinks the web address from the user' do
        expect { subject }.to change { user.web_addresses.exists?(web_address.id) }.from(true).to(false)
      end

      it 'destroys the web address' do
        expect { subject }.to change { web_address.persisted? }.from(true).to(false)
      end

      it 'destroys its problems as well' do
        expect { subject }.to change { web_address.problems.any? }.from(true).to(false)
      end
    end

    context 'if the web address is linked with many users' do
      let(:another_user) { create(:user) }

      before { another_user.web_addresses << web_address }

      it 'unlinks the web address from the user' do
        expect { subject }.to change { user.web_addresses.exists?(web_address.id) }.from(true).to(false)
      end

      it 'does not destroy the web address' do
        expect { subject }.not_to change { web_address.persisted? }.from(true)
      end

      it 'does not destroy any problems' do
        expect { subject }.not_to change { web_address.problems.any? }.from(true)
      end
    end
  end
end
