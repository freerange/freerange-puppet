class redis {
  package { "redis-server":
    ensure => installed
  }
  
  service { "redis": 
    require => Package["redis-server"],
    ensure => running 
  }
}