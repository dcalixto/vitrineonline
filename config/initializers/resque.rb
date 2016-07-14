require 'resque/server'
require 'resque_web'


Dir[File.join(Rails.root, 'app', 'models', '*.rb')].each { |file| require file }
