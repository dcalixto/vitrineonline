require ::File.expand_path('../config/environment', __FILE__)
use Rack::Deflater
require "rack/secure_headers"

require 'httparty'


use(Rack::SecureHeaders)
run Vitrineonline::Application
