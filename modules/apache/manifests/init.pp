class apache {
  include ufw, monit

  package { ["apache2-mpm-prefork", "apache2-prefork-dev", "libapr1-dev", "libaprutil1-dev"]:
    ensure => installed
  }
    
  file {"/var/www": 
    ensure => directory, 
    owner => freerange,
    group => freerange
  }

  file {"/var/log/apache2":
    ensure => directory,
    owner => root,
    group => admin
  }
    
  service { "apache2": 
    require => Package["libaprutil1-dev", "libapr1-dev", "apache2-mpm-prefork", "libapr1-dev"] 
  }
  
  file {"/etc/apache2/sites-available/default":
    ensure => absent,
    notify => Service[apache2]
  }
  
  file {"/etc/apache2/sites-available/default-ssl":
    ensure => absent,
    notify => Service[apache2]
  }
  
  file {"/etc/apache2/sites-enabled/000-default":
    ensure => absent,
    notify => Service[apache2]
  }
  
  file { "/etc/monit.d/apache.monit": 
    ensure => present,
    source => "/etc/puppet/modules/apache/files/apache.monit",
    owner => root,
    group => root,
    notify => Service["monit"]
  }
  
  ufw::allow {"Apache Full":
    require => Package["libaprutil1-dev", "libapr1-dev", "apache2-mpm-prefork", "libapr1-dev"]
  }
}