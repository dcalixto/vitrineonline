web: bundle exec rails server
elasticsearch: sudo bundle exec elasticsearch
redis: bundle exec redis-server
memcached: bundle exec memcached
private_pub: bundle exec rackup private_pub.ru -s thin -E production
work: bundle exec rake resque:work QUEUE=rollbar

work: bundle exec rake resque:work QUEUE=mailer




