git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


source 'http://rubygems.org'

gem 'rails', '3.2.22'

#ANALYTICS
gem 'garelic'

#Log

gem "lograge"

gem 'rollbar', '~> 2.8.3'
gem 'newrelic_rpm'
#gem 'notable'

# SEARCH

gem 'will_paginate'
gem 'ransack'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'searchkick',  github: "ankane/searchkick"

#CHART
gem "chartkick"
gem 'groupdate'
gem 'hightop'

# MOBILE

gem 'mobile-fu'

#ADMIN
#gem "administrate", "~> 0.1.4"

# MISC
gem 'deadweight'

gem 'csscss'
gem 'friendly_id'
gem 'mail_form'
gem 'annotate' # , :git => 'git://github.com/ctran/annotate_models.git'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'gretel'
gem 'test-unit', '~> 3.0'
gem 'select2-rails'

# MODEL
gem 'goldiloader'
gem 'counter_culture', '~> 0.1.33'


gem 'acts_as_votable', '~> 0.10.0'
gem 'shareable'
gem 'dynamic_selectable', git: 'https://github.com/dcalixto/dynamic_selectable.git'
gem 'predictor'

# CPF CNPJ

gem 'act_as_cnpj_cpf'

# AMAZON EC2
gem 'open4'
gem 'mina'
gem 'mina-newrelic'

# WISHLIST

gem 'markable'

# SHIPPING
gem 'correios-frete'

# COMMENTABLE SYSTEM

gem 'acts_as_commentable'

# FORM
gem 'formtastic', :git => 'git://github.com/dcalixto/formtastic.git', :branch => '3.1.3'

# ANALYS

#FEEDS
gem 'feedjira'

# MARKUP LANGUAGE
gem 'redcarpet'
gem 'md_emoji'

# => EMOJIS


# FACEBOOK AUTH

gem 'omniauth-facebook'

# PAYMENT
gem 'paypal_adaptive'
gem 'configatron' # , '3.1.3'
gem 'prawn'#, '1.0.0.rc2'

# ADMIN & SECURITY

gem 'validate_url'
gem 'active_model_otp'
gem 'rack-attack'
gem 'geocoder'
gem 'twilio-ruby'
# IMAGE

gem 'carrierwave','~> 0.9.0'
gem 'mini_magick'
gem 'dropzonejs-rails'
# RATING PLUGIN

gem 'jquery-raty-rails'

# DELAY_JOB
gem 'delayed_job', git: 'https://github.com/dcalixto/delayed_job.git'
gem 'delayed_job_active_record'


# STATIC PAGES
gem 'high_voltage' # , '~> 2.1.0'

# FACEBOOK SHARE
 gem 'social-share-button', git: 'https://github.com/dcalixto/social-share-button.git'

# CACHE
gem 'memcachier'
gem 'dalli'


# MESSAGE
gem 'rails-timeago'
gem 'private_pub'
gem 'thin'

# SEO
gem 'meta-tags', require: 'meta_tags'
gem 'canonical_dude'

# JAVASCRIPT & JSON
gem 'jquery-rails' # , "< 3.0.0"
gem 'jquery-rails-cdn'
gem 'oj'
gem 'json'
gem 'jquery-ui-rails' # , '~> 4.2.1'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'sqlite3'
  gem 'rails_mail_preview'
  gem 'bullet'
  gem 'ruby_gntp'
  gem 'brakeman'
  gem 'better_errors'
  gem 'dotenv-rails'
  gem 'rubocop', require: false
   gem "letter_opener"
  gem 'binding_of_caller'
  gem 'meta_request'

end
 gem "mail_view", "~> 2.0.4"
 gem  'premailer'

group :production do
  gem 'pg'
end

gem 'wicked'
#gem 'debugger'
