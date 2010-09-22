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

    $mysql_password = template("mysql/password.erb")

    package {"passwdgen":
      ensure => present
    }

    package {"mysql-server":
      ensure => present
    }

    service {"mysqld":
      require => Package["mysql-server"],
      ensure => running,
      enable => true
    }

    exec { "Initialize MySQL server root password":
      unless      => "/usr/bin/test -f /root/.my.cnf",
      command     => "/usr/bin/mysqladmin -uroot password ${mysql_password}",
      notify      => File["/root/.my.cnf"],
      require     => [Package["mysql-server"], Service["mysqld"]]
    }

    file { "/root/.my.cnf":
      content => "[mysql]\nuser=root\npassword=${mysql_password}\n[mysqladmin]\nuser=root\npassword=${mysql_password}\n[mysqldump]\nuser=root\npassword=${mysql_password}\n[mysqlshow]\nuser=root\npassword=${mysql_password}\n",
      mode => 600,
      replace => false
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