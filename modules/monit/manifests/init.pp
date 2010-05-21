class monit {
  package { "monit":
    ensure => installed
  }

  file { "/etc/default/monit":
    source => "/etc/puppet/modules/monit/files/etc-default-monit",
    owner => root,
    group => root,
    notify => Service["monit"],
    require => Package["monit"]
  }
  
  file { "/etc/monit/monitrc":
    source => "/etc/puppet/modules/monit/files/monitrc",
    owner => root,
    group => root,
    mode => 700,
    notify => Service["monit"],
    require => File["/etc/default/monit"]
  }
  
  file { "/etc/monit.d":
    ensure => directory, 
    owner => root,
    group => root,
    notify => Service["monit"],
    require => File["/etc/monit/monitrc"]
  }

  service { "monit": 
    require => File["/etc/monit.d"],
    ensure => running 
  }

  define config($source) {
    file { "/etc/monit.d/$name.monit":
      ensure => present,
      source => $source,
      owner => root,
      group => root,
      notify => Service["monit"]
    }
  }
}