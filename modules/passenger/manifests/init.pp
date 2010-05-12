class passenger {
  include apache

  package { "passenger":
    ensure => latest,
    provider => "gem",
    require => Package["libaprutil1-dev", "libapr1-dev", "apache2-mpm-prefork", "libapr1-dev"]
  }
      
  # This command is a bit extreme, so here's a brief idea of what it does.  passenger-install-apache-module
  # compiles the apache module and outputs how to integrate it.  This is piped into a sed command to remove
  # all whitespace, and then the three apache directives are extracted with grep
    
  exec { "passenger-install-apache2-module":
    command => "/usr/local/bin/passenger-install-apache2-module --auto | sed -e 's/[[:cntrl:]]\\[[[:digit:]]m//' | grep -e 'LoadModule' -e 'PassengerRoot' -e 'PassengerRuby' > /etc/apache2/mods-available/passenger.load",
    require => Package["passenger"],
    refreshonly => true
  }

  exec { "/usr/sbin/a2enmod passenger":
    require => Exec["passenger-install-apache2-module"],
    notify => Service[apache2]
  }
    
  define host($host, $ensure) {
    file { "$host":
      path => "/etc/apache2/sites-available/$name",
      owner => root,
      group => root,
      mode => 644,
      content => template("/etc/puppet/modules/passenger/templates/rack_host.erb"),
      notify => Service[apache2]
    }

    case $ensure {
		default : { err ( "unknown ensure value '${ensure}', should be either enabled or disabled" ) }
		enabled: {
			exec { "/usr/sbin/a2ensite $name":
			  notify => Service[apache2]
			}
		}

		disabled: {
			exec { "/usr/sbin/a2dissite $name":
			  notify => Service[apache2]
			}
		}
	}
  }
}