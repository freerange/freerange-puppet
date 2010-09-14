class redis {
  $version = 'v1.3.12'
  $version_path = "/usr/local/src/redis-$version"
  $bin = "/usr/local/bin"
  
  file {"/usr/local/src/redis-$version":
    ensure => "directory",
    owner => root,
    group => root
  }
  
  exec {"extract-redis": 
    command =>"wget http://github.com/antirez/redis/tarball/$version -O redis_$version.tar.gz && tar --strip-components 1 -xzvf redis_$version.tar.gz",
    cwd => "$version_path",
    creates => "$version_path/redis.c",
    require => File["$version_path"],
    before => Exec["make-redis"]
  }
  
  exec { "make-redis":
    command => "sh -c \"cd $version_path && make && mv redis-server $bin/ && mv redis-cli $bin/ && mv redis-benchmark $bin/ && mv redis-check-dump $bin/\"",
    creates => "$bin/redis-server",
  }

  file { "/etc/init.d/redis":
    content => template("redis/redis-init-script"),
    require => Exec["make-redis"],
    mode => 700
  }

  file { "/etc/redis":
    ensure => directory,
    require => Exec["make-redis"]
  }

  file { "/etc/redis/redis.conf":
    ensure => present,
    content => template("redis/redis.conf"),
    require => File["/etc/redis"],
    notify => Service["redis"]
  }

  service { "redis":
    ensure => running
  }
}