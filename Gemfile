git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


source 'http://rubygems.org'

gem 'rails', '3.2.22'





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


#EDIT IN PLACE
#gem 'best_in_place'#, '~> 3.0.1'
gem 'best_in_place', github: 'bernat/best_in_place'
# SUGGESTIONS
gem 'predictor'


#REPUTAION


gem 'acts_as_votable', '~> 0.10.0'


# CHART
#gem "chartkick"
#gem 'groupdate'

#TASK SHEDULE
gem 'whenever', require: false


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

gem 'dynamic_selectable', github: "dcalixto/dynamic_selectable"
#gem "select2-rails"

#FOREMAN

gem 'foreman'



# CPF CNPJ & FRETE
gem 'act_as_cnpj_cpf'
gem 'correios-frete'


# DEPLOY

gem 'mina', github: "dcalixto/mina", :tag => 'v0.3.1'
gem 'mina-stack',  github:"dcalixto/mina-stack-1", group: :development, require: false


# SHIPPING & PROMO CODE

#gem 'promo'



# FORM
gem 'formtastic', github: "dcalixto/formtastic", :branch => '3.1.3'




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
#gem 'dropzonejs-rails'




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


# REDIS
gem 'redis'
gem 'redis-rails'
gem "redis-rack-cache"
gem 'hiredis'
gem 'redis-namespace'




#RESQUE

#gem 'resque', github: "dcalixto/resque", :require => "resque/server"
#gem 'resque_mailer',  github: "dcalixto/resque_mailer"
#
#SIDEKICQ MAILER
gem 'sidekiq',  github:"dcalixto/sidekiq"

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
#gem 'jquery-rails' # , "< 3.0.0"

gem 'oj'
gem 'json'
#gem 'jquery-ui-rails' # , '~> 4.2.1'

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




#DB
group :production do
  gem 'pg'
end



#ACTIVITY
#gem 'public_activity'#,  github: "dcalixto/public_activity", :tag => '5.4.3'


#WAI-ARIA
#gem 'waiable',  github: "dcalixto/waiable"


#OPENSEARCH
#gem 'opensearchkick',  github: "dcalixto/opensearchkick"





#LOGS

gem 'logster'
gem "lograge"








