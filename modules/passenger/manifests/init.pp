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
    
    exec { "/usr/local/bin/passenger-install-apache2-module --auto | grep -e 'LoadModule' -e 'PassengerRoot' -e 'PassengerRuby' > /etc/apache2/mods-available/passenger.load":
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