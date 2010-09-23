class munin {
  package {"munin":
    ensure => present
  }
  
  package {"munin-node":
    ensure => present
  }

  service {"munin-node":
    require => Package["munin-node"],
    ensure => running,
    enable => true
  }
}