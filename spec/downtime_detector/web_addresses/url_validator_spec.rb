require_relative '../shared/validator'

RSpec.describe WebAddresses::UrlValidator do
  it_behaves_like 'valid validator', url: Faker::Internet.url

  it_behaves_like 'invalid validator', url: nil, errors: { url: 'must be filled' }
  it_behaves_like 'invalid validator', url: '', errors: { url: 'must be filled' }
  it_behaves_like 'invalid validator', url: 'foo', errors: { url: 'is in invalid format' }
end