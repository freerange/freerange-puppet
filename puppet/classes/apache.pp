class apache {

  include "apache::$operatingsystem"

  $package_name = $operatingsystem ? {
    centos => httpd,
    default => apache2
  }

  $development_package_name = $operatingsystem ? {
    centos => httpd-devel,
    default => apache2-threaded-dev
  }

  $apache_user = $operatingsystem ? {
    centos => "apache",
    default => "www-data"
  }

  user { $apache_user:
    groups => application,
    require => [Package[httpd], Class["base::application"]],
    notify => Service[httpd]
  }

  define host($content, $ensure = enabled) {
    include apache

    file { $name:
      path => "/etc/$apache::package_name/sites-available/$name",
      owner => root,
      group => root,
      mode => 644,
      content => $content,
      require => Package[httpd],
      notify => Service[httpd]
    }

    case $ensure {
      default : { err ( "unknown ensure value '${ensure}', should be either enabled or disabled" ) }

      enabled: {
        file { "/etc/$apache::package_name/sites-enabled/$name":
          require => File[$name],
          ensure => "/etc/$apache::package_name/sites-available/$name",
          notify => Service[httpd]
        }
      }

      disabled: {
        file { "/etc/$apache::package_name/sites-enabled/$name":
          require => File[$name],
          ensure => absent,
          notify => Service[httpd]
        }
      }
    }
  }

  package { $package_name :
    ensure => present,
    alias => httpd
  }

  package { $development_package_name:
    ensure => present,
    alias => httpd-devel,
    require => Package[$package_name]
  }

  service { $package_name:
    ensure => running,
    alias => httpd,
    require => [Package[$package_name]]
  }

  class base {
    # common stuff
  }

  class ubuntu inherits apache::base {
    exec { "enable-mod-rewrite":
      command => "a2enmod rewrite",
      creates => "/etc/apache2/mods-enabled/rewrite.load",
      require => Package[apache2],
      notify => Service[apache2]
    }

    exec { "enable-mod-ssl":
      command => "a2enmod ssl",
      creates => "/etc/apache2/mods-enabled/ssl.load",
      require => Package[apache2],
      notify => Service[apache2]
    }

    exec { "enable-mod-expires":
      command => "a2enmod expires",
      creates => "/etc/apache2/mods-enabled/expires.load",
      require => Package[apache2],
      notify => Service[apache2]
    }

    exec { "enable-mod-deflate":
      command => "a2enmod deflate",
      creates => "/etc/apache2/mods-enabled/deflate.load",
      require => Package[apache2],
      notify => Service[apache2]
    }

    exec { "enable-mod-headers":
      command => "a2enmod headers",
      creates => "/etc/apache2/mods-enabled/headers.load",
      require => Package[apache2],
      notify => Service[apache2]
    }
  }

  class centos inherits apache::base {

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
      subscribe => [File["/etc/httpd/conf/httpd.conf"], File["/etc/httpd/conf.d/ssl.conf"]],
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
  }

}