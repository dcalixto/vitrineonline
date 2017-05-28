ENV['FACEBOOK_APP_ID'] = '659358070916910'
ENV['FACEBOOK_SECRET'] = 'f01f53e2ad5d8cc09758e4ca242804e2'
ENV['TWITTER_API_KEY'] = 'qr08KnOFD8HrY93MWLjPBOVIy'
ENV['TWITTER_API_SECRET'] = 'Vvr0vR5oiwvR1NaQVtdCJ3eYvuTsPJZaKnPQ1qncVYo13wEkKa'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], scope: "email, publish_actions", info_fields: 'email, first_name, last_name', provider_ignores_state: true
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
end
