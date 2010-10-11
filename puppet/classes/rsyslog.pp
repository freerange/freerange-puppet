class rsyslog {
  package {"rsyslog":
    ensure => present
  }

  service {"rsyslog":
    ensure => running
  }

  file {"/etc/rsyslog.conf":
    ensure => present,
    content => template("rsyslog/rsyslog.conf"),
    notify => Service["rsyslog"]
  }

  file {"/etc/rsyslog.d":
    ensure => directory
  }

  define config($content) {
    include rsyslog

    file {"/etc/rsyslog.d/$name.cnf":
      content => $content,
      notify => Service["rsyslog"]
    }
  }

  define rails($environment, $deploy_to) {
    config {$name:
      content => template("rsyslog/rails.conf.erb")
    }
  }
}