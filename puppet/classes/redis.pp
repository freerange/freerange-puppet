class redis {
  package {"redis-server":
    ensure => "2:1.2.0-1"
  }

  exec { "appendonly-yes":
    command => "echo 'appendonly yes' >> /etc/redis/redis.conf",
    require => Package["redis-server"]
  }

  exec { "appendfsync-everysec":
    command => "echo 'appendfsync everysec' >> /etc/redis/redis.conf",
    require => Package["redis-server"]
  }

  service { "redis-server":
    ensure => running,
    require => [Package["redis-server"], Exec["appendonly-yes"], Exec["appendfsync-everysec"]],
    enable => true
  }
}