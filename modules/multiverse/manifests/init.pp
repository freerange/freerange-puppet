class multiverse {
  file {"multiverse.list":
    path => "/etc/apt/sources.list.d/multiverse.list",
    ensure => present,
    owner => root,
    group => root,
    content => 
  "deb http://gb.archive.ubuntu.com/ubuntu/ lucid multiverse
  deb-src http://gb.archive.ubuntu.com/ubuntu/ lucid multiverse
  deb http://gb.archive.ubuntu.com/ubuntu/ lucid-updates multiverse
  deb-src http://gb.archive.ubuntu.com/ubuntu/ lucid-updates multiverse",
    notify => Exec["update apt to include multiverse"]
  }

  exec {"update apt to include multiverse":
    command => "/usr/bin/apt-get update",
    refreshonly => true
  }
}