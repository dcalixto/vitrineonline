nginx: sudo service nginx start
web: passenger start
web: bundle exec rails server
elasticsearch: sudo service elasticsearch start
redis: bundle exec redis-server
memcached: bundle exec memcached
private_pub: bundle exec rackup private_pub.ru -s thin -E production
work: bundle exec rake resque:work QUEUE=rollbar
