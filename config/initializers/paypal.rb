#PayPal::SDK.load("config/paypal.yml", Rails.env)
#PayPal::SDK.load('config/paypal.yml',  ENV['RACK_ENV'] || 'development')
PayPal::SDK.load('config/paypal.yml',  ENV['RACK_ENV'] || 'production')
PayPal::SDK.logger = Rails.logger
