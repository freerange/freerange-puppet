stage { "pre-flight": before => Stage[main] }
class { "base": stage => "pre-flight" }

class base {
  include base::time
  include base::application

  host { "$hostname.lan" :
    ensure => present,
    host_aliases => $hostname,
    ip => "127.0.0.1"
  }

  host { "localhost" :
    ensure => present,
    ip => "127.0.0.1"
  }

  package {"tcpdump":
    ensure => present
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
      unless => "test `hostname` = '$hostname'"
    }

    file { "/etc/hostname":
      content => $hostname
    }
  }
}
