ENV['FACEBOOK_APP_ID'] = '166642276860638'
ENV['FACEBOOK_SECRET'] = 'f1c33efc1f05a6a9750fe27981548c5f'
ENV['TWITTER_API_KEY'] = 'qr08KnOFD8HrY93MWLjPBOVIy'
ENV['TWITTER_API_SECRET'] = 'Vvr0vR5oiwvR1NaQVtdCJ3eYvuTsPJZaKnPQ1qncVYo13wEkKa'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], scope: "email, publish_actions", info_fields: 'email, first_name, last_name', provider_ignores_state: true
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
end
