Capistrano::Configuration.instance(:must_exist).load do
  default_run_options[:pty]     = true # needed for git password prompts
  ssh_options[:forward_agent]   = true # use the keys for the person running the cap command to check out the app

  set :puppet_dryrun, false
  set :puppet_debug, false
  set :puppet_path, '/tmp/puppet_recipes'
  set :puppet_app_modules_path, "#{puppet_path}/apps"
  
  namespace :puppet do
    desc "Deploy our puppet recipes to the server"
    task :deploy_recipes do
      run "rm -rf #{puppet_path}"
      upload File.expand_path("../../../puppet", __FILE__), puppet_path
    end
    
    desc 'Apply puppet configuration'
    task :apply do
      apply_manifest "#{puppet_path}/site.pp"
    end
    
    desc 'Dryrun puppet configuration'
    task :dryrun do
      set :puppet_dryrun, true
    end
    
    desc 'Debug puppet configuration'
    task :debug do
      set :puppet_debug, true
    end

    task :bootstrap do
      run 'wget -q -O - http://github.com/freerange/freerange-puppet/raw/master/puppet/centos-bootstrap.sh | sh'
    end
  end
  
  def apply_manifest(manifest, options = {})
    dryrun_option = fetch('puppet_dryrun') ? "--noop " : ""
    debug_option = fetch('puppet_debug') ? "-d " : ""
    run "puppet --modulepath #{puppet_app_modules_path} --templatedir #{puppet_path}/classes #{dryrun_option}-v #{debug_option}#{manifest}", options
  end
  
  def manifest(role, manifest = nil, &block)
    require 'erb'
    
    name = "#{role}-manifest"
    top.namespace :puppet do
      task name, :roles => [role.to_sym] do
        manifest = block.call if manifest.nil?
        put ERB.new(manifest).result(binding), "#{puppet_path}/roles/#{application}-#{stage}-#{role}.pp", :roles => [role.to_sym]
      end
      
      before "puppet:apply" do
        puppet.send name
      end
    end
  end
end