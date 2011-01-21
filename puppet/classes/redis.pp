class redis($bind_address = "127.0.0.1", $appendonly = "no", $appendfsync = "always") {

  package {"redis-server":
    ensure => "2:1.2.0-1"
  }

  file { "/etc/redis/redis.conf":
    content => template("redis/redis.conf.erb"),
    owner => root,
    group => root,
    require => Package["redis-server"],
    notify => Service["redis-server"]
  }

  service { "redis-server":
    ensure => running,
    require => Package["redis-server"],
    enable => true
  }
}