class mysql {
  class client {
    package {"mysql":
      ensure => present
    }
    
    package {"mysql-devel":
      ensure => present
    }
  }
  
  class server {
    include mysql::client
    
    package {"mysql-server":
      ensure => present
    }
    
    service {"mysqld":
      require => Package["mysql-server"],
      ensure => running
    }

    define db( $user, $password ) {
      exec { "create-${name}-db":
        unless => "/usr/bin/mysql -uroot ${name}",
        command => "/usr/bin/mysql -uroot -e \"create database ${name};\"",
        require => Service["mysqld"],
      }

      exec { "grant-${name}-db":
        unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
        command => "/usr/bin/mysql -uroot -e \"grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
        require => [Service["mysqld"], Exec["create-${name}-db"]]
      }
    }
  }
}