release: bundle exec hanami db migrate
web: bundle exec hanami server
worker: bundle exec sidekiq -e production -r ./config/boot.rb -C ./config/sidekiq.yml