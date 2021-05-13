require_relative '../../../../apps/web/controllers/session/new'

RSpec.describe Web::Controllers::Session::New do
  subject { described_class.new.call({ 'rack.session' => { user_id: user_id } }) }

  context 'if user was signed in' do
    let(:user_id) { Fabricate(:user).id }

    it 'redirects' do
      expect(subject[0]).to eq(302)
    end

    it 'redirects to web addresses_path path' do
      expect(subject[1]['location']).to eq(Web.routes.web_addresses_path)
    end
  end

  context 'if user was not signed in' do
    let(:user_id) { nil }

    it 'responds with code 200' do
      expect(subject[0]).to eq(200)
    end
  end
end