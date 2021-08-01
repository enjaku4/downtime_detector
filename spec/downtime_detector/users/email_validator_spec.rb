require_relative '../shared/validator'

RSpec.describe Users::EmailValidator do
  it_behaves_like 'valid validator', email: Faker::Internet.email
  it_behaves_like 'valid validator', email: nil

  it_behaves_like 'invalid validator', email: '', errors: { email: 'must be filled' }
  it_behaves_like 'invalid validator', email: 'foo', errors: { email: 'is in invalid format' }
end