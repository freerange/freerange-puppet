class mysql {

  class client {
    $package_name = $operatingsystem ? {
      centos => mysql,
      default => mysql-client
    }

    $development_package_name = $operatingsystem ? {
      centos => mysql-devel,
      default => libmysqlclient-dev
    }

    package { $package_name:
      ensure => present
    }

    package { $development_package_name:
      ensure => present
    }
  }

  class server {
    include mysql::client

    $mysql_password = template("mysql/password.erb")

    package {"mysql-server":
      ensure => present
    }

    $service_name =  $operatingsystem ? {
      centos => mysqld,
      default => mysql
    }

    service {$service_name:
      require => Package["mysql-server"],
      ensure => running,
      alias => mysql-server,
      enable => true
    }

    exec { "Initialize MySQL server root password":
      unless      => "/usr/bin/test -f /root/.my.cnf",
      command     => "/usr/bin/mysqladmin -uroot password ${mysql_password}",
      notify      => File["/root/.my.cnf"],
      require     => [Package["mysql-server"], Service[mysql-server]]
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
        require => Service[mysql-server],
      }

      exec { "grant-${name}-db":
        unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
        command => "/usr/bin/mysql -uroot -e \"grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
        require => [Service[mysql-server], Exec["create-${name}-db"]]
      }
    }
  }
}