git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


source 'http://rubygems.org'

gem 'rails', '3.2.22'


#ANALYTICS

gem 'rollbar', '~> 2.8.3'
#gem 'newrelic_rpm'

#TABS
gem 'bettertabs', github: "dcalixto/bettertabs"


#RESPONSIVE
gem "breakpoint", "~>2.7.0"

# SEARCH

gem 'will_paginate'
gem 'ransack'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'searchkick',  github: "dcalixto/searchkick"




# SUGGESTIONS
gem 'predictor'


#REPUTAION


gem 'acts_as_votable', '~> 0.10.0'


# CHART
#gem 'chartjs-ror'

# MOBILE

gem 'mobile-fu'

#ADMIN
gem 'admin_interface', github: "dcalixto/admin_interface"
gem 'kaminari'
gem 'inherited_resources'
gem 'simple_form'
gem 'dynamic_form'
gem 'i18n_country_select'



# FIND UNUSED CSS
#gem 'deadweight'
#gem 'csscss'

# SEO
gem 'meta-tags', require: 'meta_tags'
gem 'canonical_dude'
gem 'gretel'
gem 'friendly_id'


#CLIENT SIDE VALIDATION
#gem 'html5_validators',  github: "dcalixto/html5_validators"

#DB ANOTATION
gem 'annotate' # , :git => 'git://github.com/ctran/annotate_models.git'


#COMTACT
gem 'mail_form'

#SELECT
gem 'select2-rails'
gem 'dynamic_selectable', github: "dcalixto/dynamic_selectable"


#FOREMAN

gem 'foreman'


#LOG
gem "lograge"

# CPF CNPJ & FRETE
gem 'act_as_cnpj_cpf'
gem 'correios-frete'


# DEPLOY

gem 'mina',  github: "dcalixto/mina"
gem 'mina-newrelic'
#gem 'mina-foreman', github: "dcalixto/mina-foreman"
# SHIPPING & PROMO CODE

#gem 'promo'

# COMMENTABLE SYSTEM
gem 'acts_as_commentable'

# FORM
gem 'formtastic', github: "dcalixto/formtastic", :branch => '3.1.3'
# ANALYS

#FEEDS
#gem 'feedjira'

# MARKUP LANGUAGE
gem 'redcarpet'
gem 'md_emoji'



# PAYMENT
gem 'paypal_adaptive'
gem 'configatron' # , '3.1.3'
gem 'prawn'#, '1.0.0.rc2'
#gem 'mymoip'





# ADMIN & SECURITY
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'rack-attack'
gem 'geocoder'
gem 'rack-secure_headers',   github: "dcalixto/rack-secure_headers"
gem 'no_cache_control',     github: "dcalixto/no_cache_control"

# IMAGE
gem 'carrierwave','~> 0.9.0'
gem 'mini_magick'
gem 'dropzonejs-rails'
# RATING PLUGIN

gem 'jquery-raty-rails'





# STATIC PAGES
gem 'high_voltage' # , '~> 2.1.0'

# FACEBOOK AUTH & SHARE AND OTHERS
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'social-share-button',  github: "dcalixto/social-share-button"
gem "koala", "~> 2.2"
gem 'twitter'


# CACHE
gem 'memcachier'
gem 'dalli'
gem 'memcached-manager'
#MAILER

gem 'resque', github: "dcalixto/resque"
gem 'resque_mailer'
gem 'resque-web',  require: 'resque_web'

gem "sinatra", require: 'sinatra/base'
gem "sinatra-contrib", '~> 1.3.2',  require: false


# MESSAGE
gem 'rails-timeago'
gem 'private_pub'
gem 'thin'

#MILTISETP FORM
gem 'wicked'


gem 'test-unit', '~> 3.0'

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

#MAILER
gem  'premailer'
gem 'nokogiri'
group :production do
  gem 'pg'
end
