Capistrano::Configuration.instance(:must_exist).load do
  default_run_options[:pty]     = true # needed for git password prompts
  ssh_options[:forward_agent]   = true # use the keys for the person running the cap command to check out the app

  set :user, "freerange"
  set :puppet_dryrun, false
  
  namespace :puppet do
    desc 'Bootstrap server, installing puppet and git'
    task :bootstrap do
      run "wget -q -O - http://github.com/freerange/freerange-puppet/raw/master/bootstrap.sh | sh"
      puppet.apply
    end
    
    desc 'Update puppet configuration from repository'
    task :update do
      p roles
      #run "cd /etc/puppet; #{sudo} git pull"
    end
    
    desc 'Apply puppet configuration'
    task :apply do
      puppet.update
      apply_manifest "/etc/puppet/manifests/site.pp"
    end
    
    desc 'Dryrun puppet configuration'
    task :dryrun do
      puppet.update
      set :puppet_dryrun, true
      puppet.apply
    end
  end
  
  def apply_manifest(manifest, options = {})
    dryrun_option = fetch('puppet_dryrun') ? "--noop " : ""
    run "#{sudo} puppet #{dryrun_option}-v #{manifest}", options
  end
  
  def manifest(role, manifest)
    require 'erb'
    
    name = "#{role}-manifest"
    top.namespace :puppet do
      task name, :roles => [role.to_sym] do
        sudo "mkdir -p /etc/puppet/manifests/apps"
        put ERB.new(manifest).result(binding), "/tmp/#{application}.#{role}.pp", :roles => [role.to_sym]
        sudo "mv /tmp/#{application}.#{role}.pp /etc/puppet/manifests/apps/#{application}.#{role}.pp", :roles => [role.to_sym]
        #import = "import '#{application}.#{role}.pp'"
        #sudo "grep #{import} /etc/puppet/manifests/apps.pp; if [ \"$?\" -ne \"0\" ]; then echo #{import} >> /etc/puppet/manifests/apps.pp; fi", :roles => [role.to_sym]
      end
      
      before "puppet:apply" do
        puppet.send name
      end
    end
  end
end