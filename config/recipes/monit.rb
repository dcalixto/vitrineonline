namespace :monit do

  desc "Install Monit"
  task :install do
    invoke :sudo
    queue %{echo "-----> Installing Monit..."}
    queue "sudo apt-get -y install monit"
  end

  desc "Setup all Monit configuration"
  task :setup do
    invoke :sudo
    if monitored.any?
      queue %{echo "-----> Setting up Monit..."}
      monitored.each do |daemon|
        invoke :"monit:#{daemon}"
      end
      invoke :'monit:syntax'
      invoke :'monit:restart'
    else
      queue %{echo "-----> Skiping monit - nothing is set for monitoring..."}
    end
  end

  task(:nginx) { monit_config "nginx" }
  task(:postgresql) { monit_config "postgresql" }
  task(:redis) { monit_config "redis" }
  task(:memcached) { monit_config "memcached" }
  task(:private_pub) { monit_config "private_pub", "#{private_pub_name}" }

  %w[start stop restart syntax reload].each do |command|
    desc "Run Monit #{command} script"
    task command do
      invoke :sudo
      queue %{echo "-----> Monit #{command}"}
      queue "sudo service monit #{command}"
    end
  end
end

def monit_config(original_name, destination_name = nil)
  destination_name ||= origin_name
  path ||= monit_config_path
  destination = "#{path}/#{destination_name}"
  template "monit/#{original_name}.erb", "#{config_path}/monit/#{original_name}"
  queue echo_cmd %{sudo ln -fs "#{config_path}/monit/#{original_name}" "#{destination}"}
  queue check_symlink destination
  # queue "sudo mv /tmp/monit_#{original_name} #{destination}"
  # queue "sudo chown root #{destination}"
  # queue "sudo chmod 600 #{destination}"
end
