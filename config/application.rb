require File.expand_path('../boot', __FILE__)

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'
require 'sprockets/railtie'
require 'net/http'




Bundler.require(:default, :assets, Rails.env) if defined?(Bundler)

module Vitrineonline
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/vendor)
config.autoload_paths += %W(#{config.root}/app/sweepers)

    # config.autoload_paths += %W(#{config.root}/lib/validators)

    config.after_initialize do
      Rails.application.routes_reloader.reload!

    end


    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    config.i18n.default_locale = 'pt-BR'
    config.i18n.locale = 'pt-BR'
    config.time_zone = 'Brasilia'
    config.active_record.observers = [:message_observer]
    config.active_record.observers = [:user_sweeper, :vitrine_sweeper,  :order_sweeper]


    # config.i18n.enforce_available_locales = true

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    config.active_record.whitelist_attributes = true
    # config.assets.initialize_on_precompile = false
    config.assets.initialize_on_precompile = true

    # Enable the asset pipeline
    config.assets.enabled = true
    config.exceptions_app = routes
    #config.assets.precompile += ['jquery.js']
    config.assets.precompile += ['jquery2.js']
    config.assets.version = '1.0'

    config.middleware.use Rack::Attack


    
 

#config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }

    # Cache store
    config.cache_store = :redis_store, { host:       ENV['REDIS_HOST'],
                                      port:       ENV['REDIS_PORT'],
                                      db:         ENV['REDIS_DB'],
                                      namespace:  'cache',
                                      driver:     :hiredis,
                                       expires_in: 90.minutes }

    # Logster
    Logster.set_environments([:development, :production])
    Logster.store = Logster::RedisStore.new Redis.new(host:      ENV['REDIS_HOST'],
                                                      port:      ENV['REDIS_PORT'],
                                                      db:        ENV['REDIS_DB'],
                                                      namespace: 'logster',
                                                     driver:    :hiredis)

  end
end
