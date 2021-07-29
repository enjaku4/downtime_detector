require_relative '../shared/validator'

RSpec.describe WebAddresses::UrlValidator do
  it_behaves_like 'valid validator', { url: 'https://google.com' }

  it_behaves_like 'invalid validator', { url: '' }, :url, 'must be filled'
  it_behaves_like 'invalid validator', { url: nil }, :url, 'must be filled'
  it_behaves_like 'invalid validator', { url: 1 }, :url, 'must be a string'
  it_behaves_like 'invalid validator', { url: 'foo' }, :url, 'is in invalid format'
end