FactoryBot.define do
  factory :web_address do
    url { 'https://google.com' }
    status { :unknown }
  end
end
