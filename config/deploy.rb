require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina-stack'

set :app,                 'vitrineonline'
set :server_name,         'vitrineonline.com'
set :keep_releases,       1
set :branch, 'master'
set :identity_file, '/Users/danielcalixto/gsg-keypair'
#set :domain,              '52.87.228.48'
#set :user,                'ubuntu'
#set :deploy_to,           '/home/ubuntu/vitrineonline'
#set :repository,          'git@github.com:dcalixto/vitrineonline.git'
#set :deploy_server,       'production'                   # just a handy name of the server
#set :rails_env,           'production'
#set :branch,              'master'
set :forward_agent, true
set :term_mode, nil
set :port, '22'
set :rbenv_path, '$HOME/.rbenv'

set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')




task :setup do
  # command %{rbenv install 2.3.0}

  in_path(fetch(:shared_path)) do

    command %[mkdir config]

    # Create database.yml for Postgres if it doesn't exist
    path_database_yml = "config/database.yml"
    database_yml = %[production:
    database: #{fetch(:user)}
    adapter: postgresql
    password: 152567
    encoding: Unicode
    database: vitrineonline_production
    pool: 5
    timeout: 5000]
    command %[test -e #{path_database_yml} || echo "#{database_yml}" > #{path_database_yml}]

    # Create secrets.yml if it doesn't exist
    path_secrets_yml = "config/secrets.yml"
    secrets_yml = %[production:\n  secret_key_base:\n    #{`rake secret`.strip}]
    command %[test -e #{path_secrets_yml} || echo "#{secrets_yml}" > #{path_secrets_yml}]

    # Remove others-permission for config directory
    command %[chmod -R o-rwx config]



  end


end









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






