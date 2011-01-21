# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{freerange-puppet}
  s.version = "1.1.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Roos, Tom Ward, Kalvir Sandhu, James Mead, James Adam"]
  s.date = %q{2011-01-21}
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
    "puppet/classes/apt.pp",
    "puppet/classes/base.pp",
    "puppet/classes/base/hosts",
    "puppet/classes/base/ntp/ntpd-sysconfig",
    "puppet/classes/freerange.pp",
    "puppet/classes/iptables.pp",
    "puppet/classes/iptables/load-iptables",
    "puppet/classes/iptables/post-iptables",
    "puppet/classes/iptables/pre-iptables",
    "puppet/classes/mongo.pp",
    "puppet/classes/monit.pp",
    "puppet/classes/monit/monit.conf",
    "puppet/classes/munin.pp",
    "puppet/classes/munin/plugins/passenger_memory_stats",
    "puppet/classes/munin/plugins/passenger_status",
    "puppet/classes/munin/plugins/rails_database_time",
    "puppet/classes/munin/plugins/rails_request_duration",
    "puppet/classes/munin/plugins/rails_request_error",
    "puppet/classes/munin/plugins/rails_requests",
    "puppet/classes/munin/plugins/rails_view_render_time",
    "puppet/classes/munin/rails-plugin-config",
    "puppet/classes/mysql.pp",
    "puppet/classes/mysql/password.erb",
    "puppet/classes/openswan.pp",
    "puppet/classes/openswan/ipsec.conf",
    "puppet/classes/openswan/ipsec.secrets",
    "puppet/classes/openswan/patched_ipsec_initd_script",
    "puppet/classes/openswan/secret.erb",
    "puppet/classes/post-flight.pp",
    "puppet/classes/postfix.pp",
    "puppet/classes/postfix/main.cf",
    "puppet/classes/rack.pp",
    "puppet/classes/rack/centos/passenger.load.erb",
    "puppet/classes/rack/ubuntu/passenger.conf.erb",
    "puppet/classes/redis.pp",
    "puppet/classes/ruby.pp",
    "puppet/classes/ruby/gemrc",
    "puppet/classes/sudo.pp",
    "puppet/classes/sudo/sudoers",
    "puppet/classes/syslogng.pp",
    "puppet/classes/syslogng/CentOS.cnf",
    "puppet/classes/syslogng/Ubuntu.cnf",
    "puppet/classes/xml.pp",
    "puppet/classes/yum.pp",
    "puppet/classes/zsh.pp",
    "puppet/modules/bobsh-iptables-1.2.0/COPYING",
    "puppet/modules/bobsh-iptables-1.2.0/Modulefile",
    "puppet/modules/bobsh-iptables-1.2.0/README.rst",
    "puppet/modules/bobsh-iptables-1.2.0/Rakefile",
    "puppet/modules/bobsh-iptables-1.2.0/lib/puppet/test/iptables.rb",
    "puppet/modules/bobsh-iptables-1.2.0/lib/puppet/type/iptables.rb",
    "puppet/modules/bobsh-iptables-1.2.0/metadata.json",
    "puppet/modules/bobsh-iptables-1.2.0/tests/010_basic.pp",
    "puppet/modules/bobsh-iptables-1.2.0/tests/020_icmp_types.pp",
    "puppet/modules/bobsh-iptables-1.2.0/tests/021_icmp_any.pp",
    "puppet/modules/bobsh-iptables-1.2.0/tests/030_multiple_sources.pp",
    "puppet/modules/bobsh-iptables-1.2.0/tests/040_state_types.pp",
    "puppet/modules/bobsh-iptables-1.2.0/tests/050_sport_and_dport.pp",
    "puppet/roles/blank.pp",
    "puppet/site.pp",
    "puppet/ubuntu-bootstrap.sh"
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
