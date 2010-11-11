class redis {
  package {"redis-server":
    ensure => present
  }

  exec { "bind-local":
     command => "echo 'bind 127.0.0.1' >> /etc/redis/redis.conf",
     require => Package["redis-server"]
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
    require => [Package["redis-server"], Exec["bind-local"], Exec["appendonly-yes"], Exec["appendfsync-everysec"]],
    enable => true
  }
}