class iptables {
  exec { "iptables-restore":
    command => "iptables-restore < /etc/iptables.rules",
    require => [File["/etc/iptables.rules"], File["/etc/network/if-pre-up.d/load-iptables"]]
  }

  file { "/etc/iptables.rules":
    content => template("iptables/iptables.rules"),
    owner => root,
    group => root
  }

  file { "/etc/network/if-pre-up.d/load-iptables":
    content => template("iptables/load-iptables"),
    owner => root,
    group => root,
    mode => 700
  }
}
