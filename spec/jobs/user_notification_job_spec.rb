require 'rails_helper'

describe WebAddresses::UsersNotificationJob, type: :job do
  let(:web_address) { create(:web_address, url: 'http://google.com') }
  let(:user) { create(:user, email: 'foo@bar.baz') }

  before do
    user.web_addresses << web_address
    create(:user).web_addresses << web_address
    create(:user)
  end

  it "sends notifications to the web address\'s users having an email" do
    expect { described_class.perform_now(web_address.id) }.to enqueue_job(ActionMailer::DeliveryJob)
      .with('UserMailer', 'notification', 'deliver_now', 'http://google.com', 'foo@bar.baz')
  end
end
