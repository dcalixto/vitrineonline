Vitrineonline::Application.configure do
  config.cache_classes = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  config.assets.digest = true
  config.assets.compile = false
  # Compress JavaScripts and CSS
  config.assets.compress = true
  config.cache_store = :dalli_store

  config.lograge.enabled = true

 config.lograge.custom_options = lambda do |event|
   options = event.payload.slice(:request_id, :user_id, :visit_id)
   options[:params] = event.payload[:params].except("controller", "action")
   options
 end

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = false

  # See everything in the log (default is :info)
  config.log_level = :debug

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
config.action_mailer.default_url_options = { host: 'localhost' }

  ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: '587',
    domain: 'vitrineonline.com',
    authentication: :plain,
    user_name: 'contato@vitrineonline.com',
    password: '84rf5uk99',
    enable_starttls_auto: true
  }
end
