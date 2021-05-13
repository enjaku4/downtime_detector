require_relative '../../../../apps/web/controllers/web_addresses/index'
require_relative '../shared/authentication'

RSpec.describe Web::Controllers::WebAddresses::Index do
  it_behaves_like 'user authentication'

  subject { described_class.new.call({ 'rack.session' => { user_id: Fabricate(:user).id } }) }

  it 'responds with code 200' do
    expect(subject[0]).to eq(200)
  end
end