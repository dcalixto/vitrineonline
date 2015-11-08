ENV['FACEBOOK_APP_ID'] = '166642276860638'
ENV['FACEBOOK_SECRET'] = 'f1c33efc1f05a6a9750fe27981548c5f'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], provider_ignores_state: true
end
