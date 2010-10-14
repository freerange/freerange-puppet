class rack {
  include apache

  $version = "2.2.15"

  package { "passenger":
    ensure => $version,
    provider => "gem"
  }

  exec { "passenger-install-apache2-module":
    command => "passenger-install-apache2-module --auto",
    creates => "/usr/local/lib/ruby/gems/1.8/gems/passenger-$version/ext/apache2/mod_passenger.so",
    require => [Package["passenger"], Package["httpd-devel"]]
  }

  file { "/etc/httpd/conf.d/passenger.conf":
    require => [Exec["passenger-install-apache2-module"], User[application]],
    content => template("rack/passenger.load.erb"),
    notify => Service[httpd]
  }

  define host($content, $ensure = enabled) {
    include rack

    apache::host{$name:
      content => $content,
      ensure => $ensure
    }
  }
}