release: bundle exec hanami db migrate
web: bundle exec puma -C ./config/puma.rb
worker: bundle exec sidekiq -e production -r ./config/boot.rb -C ./config/sidekiq.yml