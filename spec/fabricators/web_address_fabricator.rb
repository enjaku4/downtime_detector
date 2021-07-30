Fabricator(:web_address) do
  url { Faker::Internet.url }
end