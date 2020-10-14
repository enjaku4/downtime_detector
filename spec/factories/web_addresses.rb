FactoryBot.define do
  factory :web_address do
    sequence(:url) { |n| "https://url#{n}.com" }
    status { :unknown }
  end
end
