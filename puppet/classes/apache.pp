class apache {
  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure => present
  }

  service { "httpd":
    ensure => running,
    require => Package[httpd]
  }

  file { "/etc/httpd/conf/httpd.conf":
    content => template("apache/centos.conf"),
    owner => root,
    group => root,
    notify => Service[httpd]
  }

  file { "/etc/httpd/sites-available":
    ensure => directory,
    owner => root,
    group => root
  }

  file { "/etc/httpd/sites-enabled":
    ensure => directory,
    owner => root,
    group => root
  }
}