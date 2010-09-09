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
    require => Package["passenger"]
  }

  file { "/etc/httpd/conf.d/passenger.conf":
    require => Exec["passenger-install-apache2-module"],
    content => template("rack/passenger.load.erb"),
    notify => Service[httpd]
  }

  define host($content, $ensure = enabled) {
    include rack

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