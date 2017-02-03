require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina-stack'

set :app,                 'vitrineonline'
set :server_name,         'vitrineonline.com'
set :keep_releases,       9
set :default_server,      :production
set_default :bundle_bin, 'bundle'
set_default :bundle_path, './vendor/bundle'
set :server, ENV['to'] || default_server
invoke :"env:#{server}"

# Allow calling as `mina deploy at=master`
set :branch, ENV['at']  if ENV['at']

set :server_stack,                  %w(
                                                                       monit
                                                                        )

set :shared_paths,                  %w(
                                      tmp
                                      log
                                      config/database.yml
                                      config/application.yml
                                      public/uploads
                                    )

set :monitored,                     %w(
                                       nginx
                                       postgresql
                                       redis
                                       private_pub
                                       memcached
                                                                      )






task :'rbenv:load' do
  queue %{
    echo "-----> Loading rbenv"
    #{echo_cmd %{export PATH="#{rbenv_path}/bin:$PATH"}}

    if ! which rbenv >/dev/null; then
      echo "! rbenv not found"
      echo "! If rbenv is installed, check your :rbenv_path setting."
      exit 1
    fi

    #{echo_cmd %{eval "$(rbenv init -)"}}
  }
end


task :environment do
  queue %(
 echo "-----> Loading environment"
 #{echo_cmd %(source ~/.bashrc)}
 )




  invoke :'rbenv:load'
  command %[ export PATH="$PATH:$HOME/.rbenv/shims" ]

end
#end


desc "Deploys the current version to the server."
task :deploy do

   invoke :'rbenv:load'

  command %[ export PATH="$PATH:$HOME/.rbenv/shims" ]


  deploy do
 
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'bower:install_assets'
    invoke :'rails:assets_precompile'
     invoke :'deploy:cleanup'

    to :launch do
      invoke :'private_pub:restart'
    end
  end
end
