class openswan {
  package { "openswan":
    ensure => "1:2.6.23+dfsg-1ubuntu1"
  }

  file { "/etc/init.d/ipsec":
    content => template("openswan/patched_ipsec_initd_script"),
    owner => root,
    group => root,
    mode => 755,
    require => Package[openswan]
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

  define connection($content) {
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
    mode => 600,
    require => File["/etc/ipsec.d"]
  }

  define psk_secret($client_ip, $server_ip, $pre_shared_key) {
    include openswan

    file { "/etc/ipsec.d/$name.secret":
      owner => root,
      group => root,
      mode => 600,
      content => template("openswan/secret.erb"),
      notify => Service[ipsec]
    }
  }

  exec {"fix-runlevel":
    command => "update-rc.d -f ipsec remove && update-rc.d ipsec defaults",
    require => Package[openswan]
  }

  service { "ipsec":
    require => [Package["openswan"], File["/etc/ipsec.conf"], File["/etc/ipsec.secrets"], File["/etc/init.d/ipsec"], Exec["fix-runlevel"]],
    ensure => running,
    subscribe => [File["/etc/ipsec.conf"], File["/etc/ipsec.secrets"], File["/etc/init.d/ipsec"]]
  }

}