class apache {
  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure => present
  }

  package { "mod_ssl":
    ensure => present
  }

  service { "httpd":
    ensure => running,
    require => [Package[httpd], File["/etc/httpd/sites-enabled"]]
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