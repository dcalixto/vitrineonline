require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina-stack'

set :app,                 'vitrineonline'
set :server_name,         'vitrineonline.com'
set :keep_releases,       1
set :default_server,      :production
set :branch, 'master'
set :identity_file, '/Users/danielcalixto/gsg-keypair'

set :forward_agent, true
set :term_mode, nil
set :port, '22'
set :rbenv_path, '$HOME/.rbenv'



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

task :environment do
  invoke :'rbenv:load'
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
     # invoke :'private_pub:restart'
       in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end

    end
  end
end
