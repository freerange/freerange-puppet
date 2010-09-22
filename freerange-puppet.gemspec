# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{freerange-puppet}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Roos, Tom Ward, Kalvir Sandhu"]
  s.date = %q{2010-09-22}
  s.email = %q{lets@gofreerange.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
    "README",
    "Rakefile",
    "freerange-puppet.gemspec",
    "lib/freerange/puppet.rb",
    "puppet/centos-bootstrap.sh",
    "puppet/classes/apache.pp",
    "puppet/classes/apache/centos.conf",
    "puppet/classes/apache/ssl.conf",
    "puppet/classes/base.pp",
    "puppet/classes/base/hosts",
    "puppet/classes/base/ntp/ntpd-sysconfig",
    "puppet/classes/freerange.pp",
    "puppet/classes/mongo.pp",
    "puppet/classes/monit.pp",
    "puppet/classes/monit/monit.conf",
    "puppet/classes/munin.pp",
    "puppet/classes/mysql.pp",
    "puppet/classes/mysql/password.erb",
    "puppet/classes/rack.pp",
    "puppet/classes/rack/passenger.load.erb",
    "puppet/classes/redis.pp",
    "puppet/classes/redis/redis-init-script",
    "puppet/classes/redis/redis.conf",
    "puppet/classes/ruby.pp",
    "puppet/classes/ruby/gemrc",
    "puppet/classes/xml.pp",
    "puppet/classes/yum.pp",
    "puppet/classes/zsh.pp",
    "puppet/roles/blank.pp",
    "puppet/site.pp"
  ]
  s.homepage = %q{http://gofreerange.com}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Apply puppet configuration to freerange hosts}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano-ext>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, [">= 0"])
      s.add_dependency(%q<capistrano-ext>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 0"])
    s.add_dependency(%q<capistrano-ext>, [">= 0"])
  end
end
