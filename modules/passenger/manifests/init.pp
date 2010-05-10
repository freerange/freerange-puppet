class passenger {
  include apache

  service { "passenger":
    require => Package["passenger"]
  }

  package { "passenger":
    ensure => latest,
    provider => "gem",
    require => Service["apache2"]
  }
      
  # This command is a bit extreme, so here's a brief idea of what it does.  passenger-install-apache-module
  # compiles the apache module and outputs how to integrate it.  This is piped into a sed command to remove
  # all whitespace, and then the three apache directives are extracted with grep
    
  exec { "/usr/local/bin/passenger-install-apache2-module --auto | sed -e 's/[[:cntrl:]]\\[[[:digit:]]m//' | grep -e 'LoadModule' -e 'PassengerRoot' -e 'PassengerRuby' > /etc/apache2/mods-available/passenger.load":
    subscribe => Package["passenger"],
    refreshonly => true
  }
    
  define host($host) {
    file { "$host":
      path => "/etc/apache2/sites-available/$name.conf",
      owner => root,
      group => root,
      mode => 644,
      content => template("/etc/puppet/modules/passenger/templates/rack_host.erb"),
      notify => Service[apache2]
    }  
  }
}