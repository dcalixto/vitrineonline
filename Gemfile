git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


source 'http://rubygems.org'

gem 'rails', '3.2.22'


#ANALYTICS

gem 'rollbar'

#TABS
gem 'bettertabs', github: "dcalixto/bettertabs"


#RESPONSIVE
gem "breakpoint", "~>2.7.0"

# SEARCH

gem 'will_paginate'
gem 'ransack'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'searchkick',  github: "dcalixto/searchkick"


#DEBUG
gem 'byebug'

# SUGGESTIONS
gem 'predictor'


#REPUTAION


gem 'acts_as_votable', '~> 0.10.0'


# CHART
#gem 'chartjs-ror'


#USER AGENTE DETECTOR
gem 'device_detector'

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

gem 'mina', github: "dcalixto/mina"#, :tag => 'v1.0.6' 
gem 'mina-stack-1', "dcalixto/mina-stack-1", group: :development, require: false
# SHIPPING & PROMO CODE

#gem 'promo'



# FORM
gem 'formtastic', github: "dcalixto/formtastic", :branch => '3.1.3'
# ANALYS

#FEEDS
#gem 'feedjira'

# MARKUP LANGUAGE
gem 'redcarpet'
gem 'md_emoji'



# PAYMENT

gem 'paypal-sdk-adaptivepayments', :ref => '8fb732630247a141d0a5e374da5d640429c56f30'
gem 'configatron' # , '3.1.3'






#INVOICE DOWNLOAD
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'


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
gem 'identity_cache'
#MAILER

gem 'resque', github: "dcalixto/resque", :require => "resque/server"
gem 'resque_mailer',  github: "dcalixto/resque_mailer"
#gem 'resque-web',    github: "dcalixto/resque-web"#, require: 'resque_web'

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
  gem 'bullet', github: "dcalixto/bullet", :tag => '5.4.3'
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
group :production do
  gem 'pg'
end
