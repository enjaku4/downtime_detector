require_relative 'async'

RSpec.describe Mailers::UserNotification do
  it_behaves_like 'asynchronous mailer'

  let(:email) { Faker::Internet.email }
  let(:url) { Faker::Internet.url }

  before { Hanami::Mailer.deliveries.clear }

  it 'delivers notification email' do
    described_class.deliver(email: email, url: url)
    mail = Hanami::Mailer.deliveries.last

    expect(mail.to).to contain_exactly(email)
    expect(mail.body.encoded).to include("There is a problem with #{url}. Check your dashboard for details.")
  end
end
