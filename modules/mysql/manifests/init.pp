class mysql {
  class server {
    package {"mysql-server":
      ensure => latest
    }
  }
}