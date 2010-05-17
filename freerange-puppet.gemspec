# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{freerange-puppet}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Ward"]
  s.date = %q{2010-05-17}
  s.email = %q{lets@gofreerange.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
    "Rakefile",
    "bootstrap.sh",
    "examples/gepeto/.bundle/config",
    "examples/gepeto/Capfile",
    "examples/gepeto/Gemfile",
    "examples/gepeto/config/deploy.rb",
    "freerange-puppet.gemspec",
    "lib/freerange/puppet.rb",
    "manifests/apps/blank.pp",
    "manifests/nodes.pp",
    "manifests/site.pp",
    "modules/apache/files/apache.monit",
    "modules/apache/manifests/init.pp",
    "modules/common/README",
    "modules/common/files/empty/.ignore",
    "modules/common/files/modules/README",
    "modules/common/lib/puppet/parser/functions/basename.rb",
    "modules/common/lib/puppet/parser/functions/concat.rb",
    "modules/common/lib/puppet/parser/functions/dirname.rb",
    "modules/common/lib/puppet/parser/functions/extlookup.rb",
    "modules/common/lib/puppet/parser/functions/gsub.rb",
    "modules/common/lib/puppet/parser/functions/prefix_with.rb",
    "modules/common/lib/puppet/parser/functions/re_escape.rb",
    "modules/common/lib/puppet/parser/functions/split.rb",
    "modules/common/manifests/classes/lsb_release.pp",
    "modules/common/manifests/defines/append_if_no_such_line.pp",
    "modules/common/manifests/defines/concatenated_file.pp",
    "modules/common/manifests/defines/config_file.pp",
    "modules/common/manifests/defines/line.pp",
    "modules/common/manifests/defines/module_dir.pp",
    "modules/common/manifests/defines/module_file.pp",
    "modules/common/manifests/defines/replace.pp",
    "modules/common/manifests/init.pp",
    "modules/concat/README",
    "modules/concat/files/concatfragments.sh",
    "modules/concat/manifests/fragment.pp",
    "modules/concat/manifests/init.pp",
    "modules/concat/manifests/setup.pp",
    "modules/freerange/files/zsh/base.zsh",
    "modules/freerange/files/zsh/completion.zsh",
    "modules/freerange/files/zsh/functions/_gem",
    "modules/freerange/files/zsh/functions/sc",
    "modules/freerange/files/zsh/functions/ss",
    "modules/freerange/files/zsh/history.zsh",
    "modules/freerange/files/zsh/misc.zsh",
    "modules/freerange/files/zsh/prompt.zsh",
    "modules/freerange/manifests/init.pp",
    "modules/mongodb/manifests/init.pp",
    "modules/monit/files/etc-default-monit",
    "modules/monit/files/monitrc",
    "modules/monit/manifests/init.pp",
    "modules/ntp/manifests/init.pp",
    "modules/passenger/files/passenger.load",
    "modules/passenger/manifests/init.pp",
    "modules/rack/manifests/init.pp",
    "modules/rack/templates/apache-host.erb",
    "modules/redis/manifests/init.pp",
    "modules/ssh/files/sshd.monit",
    "modules/ssh/files/sshd_config",
    "modules/ssh/manifests/init.pp",
    "modules/ufw/manifests/init.pp",
    "modules/zsh/manifests/init.pp"
  ]
  s.homepage = %q{http://gofreerange.com}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Apply puppet configuration to freerange hosts}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
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
