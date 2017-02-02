require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina-stack'

#set :app,                 'vitrineonline'
#set :server_name,         'vitrineonline.com'
#set :keep_releases,       1
set :branch, 'master'
set :identity_file, '~/.ec2/gsg-keypair'
set :domain,              '52.87.228.48'
set :user,                'ubuntu'
set :deploy_to,           '/home/ubuntu/vitrineonline'
set :repository,          'git@github.com:dcalixto/vitrineonline.git'
set :deploy_server,       'production'                   # just a handy name of the server
set :rails_env,           'production'
set :branch,              'master'
set :forward_agent, true
set :term_mode, nil
set :port, '22'
set_default  :rbenv_path, '$HOME/.rbenv'

#set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')


set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log', 'public/uploads']

task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.

  queue %(
 echo "-----> Loading environment"
 #{echo_cmd %(source ~/.bashrc)}
 )

  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end


task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log")

  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/config")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config")

  queue! %(touch "#{deploy_to}/#{shared_path}/config/database.yml")
  queue! %(touch "#{deploy_to}/#{shared_path}/config/secrets.yml")
  queue %(echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml' and 'secrets.yml'.")

  queue! %[mkdir -p "#{deploy_to}/shared/public/uploads"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/uploads"]


  queue %(
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi &&
    ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  )
end

 






desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'


    to :launch do
      # invoke :'private_pub:restart'
      in_path(fetch(:current_path)) do
     queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      end

    end
  end
end






