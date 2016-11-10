require ::File.expand_path('../config/environment', __FILE__)
use Rack::Deflater
#require "rack/secure_headers"


#use(Rack::SecureHeaders)
run Vitrineonline::Application
