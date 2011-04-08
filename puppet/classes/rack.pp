class rack {
  include apache

  include "rack::$operatingsystem"

  $version = "2.2.15"

  $deploy_user = $operatingsystem ? {
    centos => rack,
    ubuntu => deploy
  }

  package { "passenger":
    ensure => $version,
    provider => "gem"
  }

  define host($content, $ensure = enabled) {
    include rack

    apache::host{$name:
      content => $content,
      ensure => $ensure
    }
  }

  user {"rack":
    shell => "/bin/false",
  }

  class centos($run_as_user = "application") {
    exec { "passenger-install-apache2-module":
      command => "passenger-install-apache2-module --auto",
      creates => "/usr/local/lib/ruby/gems/1.8/gems/passenger-$version/ext/apache2/mod_passenger.so",
      require => [Package["passenger"], Package["httpd-devel"]]
    }

    file { "/etc/httpd/conf.d/passenger.conf":
      require => [Exec["passenger-install-apache2-module"], User[application]],
      content => template("rack/centos/passenger.load.erb"),
      notify => Service[httpd]
    }

    file { "/var/www":
      ensure => directory,
      owner => root,
      group => rack,
      require => [User[rack], Exec["passenger-install-apache2-module"]],
      mode => 771
    }
  }

  class ubuntu($run_as_user = "application") {
    package { "libapache2-mod-passenger":
      ensure => present
    }

    file { "/etc/apache2/mods-available/passenger.conf":
      content => template("rack/ubuntu/passenger.conf.erb"),
      require => [Package["libapache2-mod-passenger"]],
      owner => root,
      group => root,
      notify => Service[apache2]
    }
  }
}