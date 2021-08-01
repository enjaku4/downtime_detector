RSpec.describe PingingService::UsersNotificationWorker do
  subject { described_class.new.perform(web_address.id) }

  let(:web_address) { Fabricate(:web_address) }
  let(:user_with_email) { Fabricate(:user, email: Faker::Internet.email) }
  let(:user_without_email) { Fabricate(:user) }

  before do
    UserHavingWebAddressRepository.new.create(user_id: user_with_email.id, web_address_id: web_address.id)
    UserHavingWebAddressRepository.new.create(user_id: user_without_email.id, web_address_id: web_address.id)

    allow(Mailers::UserNotification).to receive(:deliver_async).with(email: user_with_email.email, url: web_address.url)
  end

  it 'sends exactly one notification email' do
    subject
    expect(Mailers::UserNotification).to have_received(:deliver_async)
  end
end