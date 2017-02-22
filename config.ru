require ::File.expand_path('../config/environment', __FILE__)
use Rack::Deflater


require 'rack'
require 'rack/cache'
require 'redis-rack-cache'

require "rack/secure_headers"


use Rack::Cache,
metastore: 'redis://localhost:6379/1/metastore',
entitystore: 'redis://localhost:6379/1/entitystore'



use(Rack::SecureHeaders)
run Vitrineonline::Application
