namespace :env do
  task :production => [:environment] do
    set :domain,              '52.87.228.48'
    set :user,                'ubuntu'
    set :deploy_to,           "/home/#{user}/#{app}"
    set :repository,          "git@github.com:dcalixto/vitrineonline.git"
   # set :nginx_path,          '/etc/nginx'
    set :deploy_server,       'production'                   # just a handy name of the server
    set :rails_env,           'production'
    set :branch,              'master'
    invoke :defaults                                         # load rest of the config
  end
end