class mongo {
  class client {
    include yum
    
    file {"/etc/yum.repos.d/10gen.repo":
      ensure => present,
      owner => root,
      group => root,
      content => "[10gen]\nname=10gen Repository\nbaseurl=http://downloads.mongodb.org/distros/centos/5.4/os/i386/\ngpgcheck=0",
      notify => Exec["yum update"]
    }
  
    exec {"update apt":
      command => "/usr/bin/apt-get update",
      refreshonly => true  
    }
    
    package {"mongo-stable":
      ensure => present,
      require => File["/etc/yum.repos.d/10gen.repo"]
    }
  }
  
  class server {
    include mongo::client
    
    package {"mongo-stable-server":
      ensure => present,
      require => File["/etc/yum.repos.d/10gen.repo"]
    }
    
    service { "mongod": 
      require => Package["mongo-stable-server"],
      ensure => running,
      enable => true
    }
  }
}