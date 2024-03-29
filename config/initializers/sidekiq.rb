Sidekiq.configure_server do |config|
  config.redis = { url: "#{ENV.fetch('REDIS_URL')}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{ENV.fetch('REDIS_URL')}/0" }
end

Sidekiq::Extensions.enable_delay!