class mongodb {
  package { "mongodb":
    ensure => installed
  }
  
  service { "mongodb": 
    require => Package["mongodb"],
    ensure => running 
  }
}