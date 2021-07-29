require_relative '../../../shared/controllers/authentication'

RSpec.describe Web::Controllers::WebAddresses::Destroy do
  it_behaves_like 'user authentication'

  subject { action.call('rack.session' => { user_id: user.id }, id: web_address.id) }

  let(:action) { described_class.new }
  let(:user) { Fabricate(:user) }
  let(:web_address) { Fabricate(:web_address) }
  let(:interactor) { instance_double(::WebAddresses::Destroy) }

  before do
    allow(::WebAddresses::Destroy).to receive(:new).with(web_address: web_address, user: user).and_return(interactor)
    allow(interactor).to receive(:call)
  end

  it 'deletes web address' do
    subject
    expect(interactor).to have_received(:call)
  end

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to web root path' do
    expect(subject[1]['location']).to eq(Web.routes.root_path)
  end
end