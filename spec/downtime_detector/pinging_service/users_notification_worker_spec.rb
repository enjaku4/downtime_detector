RSpec.describe PingingService::UsersNotificationWorker do
  subject { described_class.new.perform(web_address.id) }

  let(:web_address) { Fabricate(:web_address, status: status) }
  let(:user_with_email) { Fabricate(:user, email: Faker::Internet.email) }
  let(:user_without_email) { Fabricate(:user) }

  before do
    UserHavingWebAddressRepository.new.create(user_id: user_with_email.id, web_address_id: web_address.id)
    UserHavingWebAddressRepository.new.create(user_id: user_without_email.id, web_address_id: web_address.id)
  end

  context 'if web address is faulty' do
    let(:status) { 'down' }

    it 'sends exactly one problem notification email' do
      expect(Mailers::ProblemNotification).to receive(:deliver_async)
        .with(email: user_with_email.email, web_address_id: web_address.id)
      subject
    end
  end

  context 'if web address is not faulty' do
    let(:status) { 'up' }

    it 'sends exactly one problem solved notification email' do
      expect(Mailers::ProblemSolvedNotification).to receive(:deliver_async)
        .with(email: user_with_email.email, web_address_id: web_address.id)
      subject
    end
  end
end
