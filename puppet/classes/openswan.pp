class openswan {
  package { "openswan":
    ensure => present
  }

  file { "/etc/ipsec.d":
    ensure => directory,
    owner => root,
    group => root,
    require => Package[openswan]
  }

  file { "/etc/ipsec.conf":
    content => template("openswan/ipsec.conf"),
    owner => root,
    group => root,
    require => File["/etc/ipsec.d"]
  }

  define config($content) {
    include openswan

    file { "/etc/ipsec.d/$name.conf":
      owner => root,
      group => root,
      mode => 644,
      content => $content,
      notify => Service[ipsec]
    }
  }

  file { "/etc/ipsec.secrets":
    content => template("openswan/ipsec.secrets"),
    owner => root,
    group => root,
    require => File["/etc/ipsec.d"]
  }

  define secret($content) {
    include openswan

    file { "/etc/ipsec.d/$name.secret":
      owner => root,
      group => root,
      mode => 644,
      content => $content,
      notify => Service[ipsec]
    }
  }

  service { "ipsec":
    require => [Package["openswan"], File["/etc/ipsec.conf"], File["/etc/ipsec.secrets"]],
    ensure => running,
    subscribe => [File["/etc/ipsec.conf"], File["/etc/ipsec.secrets"]]
  }

}