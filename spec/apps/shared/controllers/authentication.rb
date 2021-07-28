shared_examples_for 'user authentication' do
  subject { action.call({}) }

  let(:action) { described_class.new }

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to root path' do
    expect(subject[1]['location']).to eq(Auth.routes.root_path)
  end
end