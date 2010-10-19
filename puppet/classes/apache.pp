class apache {
  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure => present,
    require => Package["httpd"]
  }

  package { "mod_ssl":
    ensure => present
  }

  file { "/etc/httpd/conf.d/ssl.conf":
    content => template("apache/ssl.conf"),
    ensure => present,
    require => Package["mod_ssl"],
    owner => root,
    group => root
  }

  service { "httpd":
    ensure => running,
    require => [Package[httpd], File["/etc/httpd/sites-enabled"]],
    subscribe => [File["/etc/httpd/conf/httpd.conf"], File["/etc/httpd/conf.d/ssl.conf"]]
  }

  file { "/etc/httpd/conf/httpd.conf":
    content => template("apache/centos.conf"),
    owner => root,
    group => root,
    require => Package[httpd]
  }

  file { "/etc/httpd/sites-available":
    ensure => directory,
    owner => root,
    group => root,
    require => Package[httpd]
  }

  file { "/etc/httpd/sites-enabled":
    ensure => directory,
    owner => root,
    group => root,
    require => Package[httpd]
  }

  user { "apache":
    groups => application,
    require => [Package[httpd], Class["base::application"]],
    notify => Service[httpd]
  }

  define host($content, $ensure = enabled) {
    include apache

    file { $name:
      path => "/etc/httpd/sites-available/$name",
      owner => root,
      group => root,
      mode => 644,
      content => $content,
      notify => Service[httpd]
    }

    case $ensure {
      default : { err ( "unknown ensure value '${ensure}', should be either enabled or disabled" ) }

      enabled: {
        file { "/etc/httpd/sites-enabled/$name":
          require => File[$name],
          ensure => "/etc/httpd/sites-available/$name",
          notify => Service[httpd]
        }
      }

      disabled: {
        file { "/etc/httpd/sites-enabled/$name":
          require => File[$name],
          ensure => absent,
          notify => Service[httpd]
        }
      }
    }
  }
}