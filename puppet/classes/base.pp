stage { "base": before => Stage[main] }
class { "base": stage => "base" }

class base {
  include base::hosts
  include base::time
  include base::application

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

  class application {
    user {"application":
      shell => "/bin/false"
    }

    file { "/var/www":
      ensure => directory,
      owner => root,
      group => application,
      require => [User[application]],
      mode => 771
    }
  }
}