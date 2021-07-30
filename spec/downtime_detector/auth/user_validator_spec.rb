require_relative '../shared/validator'

RSpec.describe Auth::UserValidator do
  it_behaves_like 'valid validator', nickname: Faker::Internet.username(specifier: 6..9), password: Faker::Internet.password(min_length: 6)

  it_behaves_like 'invalid validator', nickname: nil, errors: { nickname: 'must be filled' }
  it_behaves_like 'invalid validator', nickname: '', errors: { nickname: 'must be filled' }
  it_behaves_like 'invalid validator', nickname: 'foo', errors: { nickname: 'size cannot be less than 6' }

  it_behaves_like 'invalid validator', password: nil, errors: { password: 'must be filled' }
  it_behaves_like 'invalid validator', password: '', errors: { password: 'must be filled' }
  it_behaves_like 'invalid validator', password: 'foo', errors: { password: 'size cannot be less than 6' }
end