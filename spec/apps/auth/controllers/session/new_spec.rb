RSpec.describe Auth::Controllers::Session::New do
  subject { described_class.new.call(params) }

  context 'if user was signed in' do
    let(:params) { Hash['rack.session' => { user_id: Fabricate(:user).id }] }

    it 'redirects' do
      expect(subject[0]).to eq(302)
    end

    it 'redirects to web app root path' do
      expect(subject[1]['location']).to eq(Web.routes.root_path)
    end
  end

  context 'if user was not signed in' do
    let(:params) { Hash.new }

    it 'responds with code 200' do
      expect(subject[0]).to eq(200)
    end
  end
end