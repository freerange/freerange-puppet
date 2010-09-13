class base {
  include base::hosts
  include base::time

  class hosts {
    file { "/etc/hosts":
      content => template("base/hosts"),
      owner => root,
      group => root
    }
  }

  class time {
    file { "/etc/localtime":
      source => "/usr/share/zoneinfo/Europe/London"
    }
    
    package {"ntp":
      ensure => present
    }
    
    service {"ntpd":
      ensure => running,
      require => Package["ntp"]
    }
    
    file {"/etc/sysconfig/ntpd":
      content => template("base/ntp/ntpd-sysconfig")
    }
  }
}