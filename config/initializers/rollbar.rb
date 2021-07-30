require 'rollbar'

Rollbar.configure do |config|
  if Hanami.env?(:production)
    config.disable_rack_monkey_patch = true
    config.access_token = ENV.fetch('ROLLBAR_ACCESS_TOKEN')
    config.enabled = true
    config.use_sidekiq
  else
    config.enabled = false
  end
end