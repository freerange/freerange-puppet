class mysql {
  class server {
    include monit
    
    $mysql_user = "root"
    $mysql_password = generate("/usr/bin/makepasswd")

    user { "mysql":
      ensure => present,
      require => Package["mysql-server"],
    }
    
    package { "mysql-server":
      ensure => latest
    }

    service { "mysql":
      ensure => running,
      require => Package["mysql-server"]
    }
    
    file { "/etc/mysql/my.cnf":
      require => Package["mysql-server"],
      source => "/etc/puppet/modules/mysql/files/my.cnf",
      notify => Service["mysql"],
      owner => root,
      group => root
    }

    exec { "Initialize MySQL server root password":
      unless      => "/usr/bin/test -f /root/.my.cnf",
      command     => "/usr/bin/mysqladmin -u${mysql_user} password ${mysql_password}",
      notify      => Exec["Generate /root/.my.cnf"],
      require     => [Package["mysql-server"], Service["mysql"]]
    }

    exec { "Generate /root/.my.cnf":
      command     => "/bin/echo -e \"[mysql]\nuser=${mysql_user}\npassword=${mysql_password}\n[mysqladmin]\nuser=${mysql_user}\npassword=${mysql_password}\n[mysqldump]\nuser=${mysql_user}\npassword=${mysql_password}\n[mysqlshow]\nuser=${mysql_user}\npassword=${mysql_password}\n\" > /root/.my.cnf",
      refreshonly => true,
      creates     => "/root/.my.cnf",
    }
    
    monit::config { "mysql":
      source => "/etc/puppet/modules/mysql/files/mysql.monit"
    }
  }
}