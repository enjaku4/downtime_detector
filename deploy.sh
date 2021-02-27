docker pull enjaku/downtime_detector:latest
docker-compose -f /home/enjaku/apps/downtime_detector/docker-compose.prod.yml run --rm web bin/rails db:migrate
docker-compose -f /home/enjaku/apps/downtime_detector/docker-compose.prod.yml stop -t 30 sidekiq
docker-compose -f /home/enjaku/apps/downtime_detector/docker-compose.prod.yml up -d web
docker-compose -f /home/enjaku/apps/downtime_detector/docker-compose.prod.yml up -d sidekiq
