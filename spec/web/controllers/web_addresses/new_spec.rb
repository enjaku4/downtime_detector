require_relative '../shared/authentication'

RSpec.describe Web::Controllers::WebAddresses::New, type: :action do
  it_behaves_like 'user authentication'

  subject { described_class.new.call({ 'rack.session' => { user_id: Fabricate(:user).id } }) }

  it 'responds with code 200' do
    expect(subject[0]).to eq(200)
  end
end
