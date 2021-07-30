source 'https://rubygems.org'

gem 'rake'
gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'slim'
gem 'pg'
gem 'bcrypt'
gem 'recaptcha'
gem 'puma'
gem 'sidekiq'
gem 'guard-sidekiq'

group :plugins do
  gem 'hanami-reloader', '~> 0.3'
end

group :development do
  gem 'byebug'
  gem 'hanami-webconsole'
  gem 'pry'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'rspec'
  gem 'hanami-fabrication'
  gem 'database_cleaner-sequel'
  gem 'rspec-github', require: false
  gem 'faker'
end
