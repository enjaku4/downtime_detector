require_relative 'shared/validator'

RSpec.describe Web::Validators::UserAuthenticationValidator do
  subject { described_class.new(args).validate }

  it_behaves_like 'valid validator', { nickname: 'foobar', password: 'password' }

  it_behaves_like 'invalid validator', { nickname: 1 }, :nickname, 'must be a string'
  it_behaves_like 'invalid validator', { nickname: nil }, :nickname, 'must be filled'
  it_behaves_like 'invalid validator', { nickname: '' }, :nickname, 'must be filled'
  it_behaves_like 'invalid validator', { nickname: 'foo' }, :nickname, 'size cannot be less than 6'

  it_behaves_like 'invalid validator', { password: 1 }, :password, 'must be a string'
  it_behaves_like 'invalid validator', { password: nil }, :password, 'must be filled'
  it_behaves_like 'invalid validator', { password: '' }, :password, 'must be filled'
  it_behaves_like 'invalid validator', { password: 'foo' }, :password, 'size cannot be less than 6'
end