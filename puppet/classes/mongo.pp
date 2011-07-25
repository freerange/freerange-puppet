class mongo {
  class client {
    include "mongo::client::$operatingsystem"

    class centos {
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

    class ubuntu {
      include apt

      exec {"get-10gen-apt-key":
        command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
      }

      file {"/etc/apt/sources.list.d/mongo.list":
        ensure => present,
        owner => root,
        group => root,
        content => "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen",
        require => Exec["get-10gen-apt-key"]
      }

      file {"/etc/mongodb.conf":
        ensure => present,
        content => template("mongo/mongodb.conf"),
        owner => root,
        group => root
      }

      exec {"update apt to find mongodb":
        command => "/usr/bin/apt-get -y update",
        require => File["/etc/apt/sources.list.d/mongo.list"]
      }

      package {"mongodb-10gen":
        ensure => "1.8.2",
        require => [Exec["update apt to find mongodb"], File["/etc/mongodb.conf"]]
      }
    }
  }

  class server {
    include mongo::client
    include "mongo::server::$operatingsystem"

    class centos {
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

    class ubuntu {
      service { "mongodb":
        require => Package["mongodb-10gen"],
        ensure => running,
        enable => true
      }
    }
  }
}