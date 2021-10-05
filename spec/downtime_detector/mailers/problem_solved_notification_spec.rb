require_relative 'async'

RSpec.describe Mailers::ProblemSolvedNotification do
  it_behaves_like 'asynchronous mailer'

  let(:email) { Faker::Internet.email }
  let(:url) { Faker::Internet.url }
  let(:web_address) { Fabricate(:web_address, url: url) }

  before { Hanami::Mailer.deliveries.clear }

  it 'delivers problem solved notification email' do
    described_class.deliver(email: email, web_address_id: web_address.id)
    mail = Hanami::Mailer.deliveries.last

    expect(mail.to).to contain_exactly(email)
    expect(mail.body.encoded).to include("Problem solved, #{url} is up again.")
  end
end
