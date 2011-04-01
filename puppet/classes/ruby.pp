# Ruby should already be installed, so this class just adds to the ruby environment]
# by adding bundler, etc.

class ruby {
  file { "/root/.gemrc":
    content => template("ruby/gemrc"),
    owner => root,
    group => root
  }
  
  package { "bundler":
    provider => "gem",
    ensure => "1.0.10",
    require => File["/root/.gemrc"]
  }

  package { "rake":
    provider => "gem",
    ensure => "0.8.7"
  }
}