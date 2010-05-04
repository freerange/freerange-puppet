Capistrano::Configuration.instance(:must_exist).load do
  default_run_options[:pty]     = true # needed for git password prompts
  ssh_options[:forward_agent]   = true # use the keys for the person running the cap command to check out the app

  set :user, "freerange"
  
  namespace :puppet do
    def puppet(data)
      sudo 'rm -f /tmp/freerange-puppet-script'
      put data, '/tmp/freerange-puppet-script'
      sudo 'puppet --modulepath="/home/freerange/puppet/modules" /tmp/freerange-puppet-script'
    end
    
    desc 'Bootstrap server, installing puppet and git'
    task :bootstrap do
      run "wget -q -O - http://github.com/freerange/freerange-puppet/raw/master/bootstrap.sh | sh"
    end
  end
end