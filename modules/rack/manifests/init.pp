class rack {
  include apache
  
  package { "passenger":
    ensure => "2.2.11",
    provider => "gem",
    require => Package["libaprutil1-dev", "libapr1-dev", "apache2-mpm-prefork", "libapr1-dev"]
  }
        
  exec { "passenger-install-apache2-module":
    command => "/usr/bin/passenger-install-apache2-module --auto",
    creates => "/usr/lib/ruby/gems/1.8/gems/passenger-2.2.11/ext/apache2/mod_passenger.so",
    require => Package["passenger"]
  }

  file { "/etc/apache2/mods-available/passenger.load":
    require => Exec["passenger-install-apache2-module"],
    source => "/etc/puppet/modules/rack/files/passenger.load",
    notify => Service[apache2]
  }

  exec { "/usr/sbin/a2enmod passenger":
    require => File["/etc/apache2/mods-available/passenger.load"],
    creates => "/etc/apache2/mods-enabled/passenger.load",
    notify => Service[apache2]
  }
  
  define host($host, $ensure) {
    include rack
  
    file { "$host":
      path => "/etc/apache2/sites-available/$name",
      owner => root,
      group => root,
      mode => 644,
      content => template("/etc/puppet/modules/rack/templates/apache-host.erb"),
      notify => Service[apache2]
    }

    case $ensure {
		  default : { err ( "unknown ensure value '${ensure}', should be either enabled or disabled" ) }
		  
		  enabled: {
			  exec { "/usr/sbin/a2ensite $name":
			    require => File["$host"],
			    notify => Service[apache2],
			    creates => "/etc/apache2/sites-enabled/$name"
			  }
		  }

	  	disabled: {
  			exec { "/usr/sbin/a2dissite $name":
  			  require => File["$host"],
  			  notify => Service[apache2]
  			}
		  }
	  }
  }
}