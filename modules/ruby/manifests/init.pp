class ruby {
  include rubygems

  # At the moment, the version of 1.8.7 REE (2010.02) is based on has a nasty bug that
  # causes puppet to fail when running (see http://redmine.ruby-lang.org/issues/show/2739).
  # This bug has been fixed in MRI 1.8.7 but not yet released so for now the brightbox REE
  # stuff is disabled, until this bug fix makes its way to Brightbox's REE.

  # When this happens, sections below can be uncommented

  # file {"brightbox":
  #   path => "/etc/apt/sources.list.d/brightbox-rubyee.list",
  #   ensure => present,
  #   owner => root,
  #   group => root,
  #   content => "deb http://apt.brightbox.net/ lucid rubyee",
  #   notify => Exec["update apt"]
  # }

  # exec {"brightbox":
  #   command => "/usr/bin/wget http://apt.brightbox.net/release.asc -O - | /usr/bin/apt-key add -",
  #   unless => "/usr/bin/apt-key list | /bin/grep Brightbox",
  #   notify => Exec["update apt"]
  # }

  exec {"update apt":
    command => "/usr/bin/apt-get update",
    refreshonly => true
  }

  package {["rdoc", "ruby", "irb", "rubygems", "libopenssl-ruby", "irb1.8", "libruby1.8", "libopenssl-ruby1.8", "libreadline-ruby1.8", "ruby1.8", "rdoc1.8", "ruby1.8-dev"]:
    ensure => latest,
  # require => [File["brightbox"], Exec["brightbox"]]
  }
}