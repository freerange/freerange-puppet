Capistrano::Configuration.instance(:must_exist).load do
  default_run_options[:pty]     = true # needed for git password prompts
  ssh_options[:forward_agent]   = true # use the keys for the person running the cap command to check out the app

  set :user, "freerange"
  set :puppet_dryrun, false
  set :puppet_debug, false
  
  namespace :puppet do
    desc 'Bootstrap server, installing puppet and git'
    task :bootstrap do
      run "wget -q -O - http://github.com/freerange/freerange-puppet/raw/master/bootstrap.sh | sh"
      puppet.apply
    end
    
    desc 'Update puppet configuration from repository'
    task :update do
      #run "cd /etc/puppet; #{sudo} git pull"
    end
    
    desc 'Apply puppet configuration'
    task :apply do
      puppet.update
      apply_manifest "/etc/puppet/manifests/site.pp"
    end
    
    desc 'Dryrun puppet configuration'
    task :dryrun do
      set :puppet_dryrun, true
    end
    
    desc 'Debug puppet configuration'
    task :debug do
      set :puppet_debug, true
    end
  end
  
  before "deploy:setup", "puppet:apply"

  def apply_manifest(manifest, options = {})
    dryrun_option = fetch('puppet_dryrun') ? "--noop " : ""
    debug_option = fetch('puppet_debug') ? "-d " : ""
    run "#{sudo} puppet #{dryrun_option}-v #{debug_option}#{manifest}", options
  end
  
  def manifest(role, manifest)
    require 'erb'
    
    name = "#{role}-manifest"
    top.namespace :puppet do
      task name, :roles => [role.to_sym] do
        sudo "mkdir -p /etc/puppet/manifests/apps"
        put ERB.new(manifest).result(binding), "/tmp/#{application}.#{role}.pp", :roles => [role.to_sym]
        sudo "mv /tmp/#{application}.#{role}.pp /etc/puppet/manifests/apps/#{application}.#{role}.pp", :roles => [role.to_sym]
      end
      
      before "puppet:apply" do
        puppet.send name
      end
    end
  end
end