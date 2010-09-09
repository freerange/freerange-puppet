class munin {
  package {"munin":
    ensure => present
  }
  
  service {"munin":
    require => Package["munin"],
    ensure => running 
  }
}