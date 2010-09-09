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
  }
}