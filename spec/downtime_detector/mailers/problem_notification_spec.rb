require_relative 'async'

RSpec.describe Mailers::ProblemNotification do
  it_behaves_like 'asynchronous mailer'

  let(:email) { Faker::Internet.email }
  let(:url) { Faker::Internet.url }
  let(:message) { Faker::Lorem.sentence }
  let(:web_address) { Fabricate(:web_address, url: url, message: message) }

  before { Hanami::Mailer.deliveries.clear }

  it 'delivers problem notification email' do
    described_class.deliver(email: email, web_address_id: web_address.id)
    mail = Hanami::Mailer.deliveries.last

    expect(mail.to).to contain_exactly(email)
    expect(mail.body.encoded).to include("A problem &laquo;#{message}&raquo; occured on #{url}.")
  end
end
