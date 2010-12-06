stage { "pre-flight": before => Stage[main] }
class { "base": stage => "pre-flight" }

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

    case  $operatingsystem {
      "CentOS":  {
        file {"/etc/sysconfig/ntpd":
          content => template("base/ntp/ntpd-sysconfig")
        }
      }

      "Debian": {
        # todo
      }
    }
  }

  class application {
    user {"application":
      shell => "/bin/false"
    }

    file { "/var/apps":
      ensure => directory,
      owner => root,
      group => application,
      require => [User[application]],
      mode => 771
    }
  }

  define set_hostname($hostname) {
    exec { "hostname":
      command => "hostname ${hostname}",
      require => [File["/etc/hostname"], Exec["update-hosts"]]
    }
    file { "/etc/hostname":
      content => $hostname
    }
    exec { "update-hosts":
      command => "echo '127.0.0.1 ${hostname}' >> /etc/hosts"
    }
  }
}
