import "iptables"

class config_iptables {

  iptables { "http":
    proto => "tcp",
    dport => "80",
    jump => "ACCEPT",
    require => [File["/etc/puppet/iptables/pre.iptables"], File["/etc/puppet/iptables/post.iptables"]],
    notify => Exec["save iptables rules"]
  }

  iptables { "https":
    proto => "tcp",
    dport => "443",
    jump => "ACCEPT",
    require => [File["/etc/puppet/iptables/pre.iptables"], File["/etc/puppet/iptables/post.iptables"]],
    notify => Exec["save iptables rules"]
  }

  iptables { "ssh":
    proto => "tcp",
    dport => "22",
    jump => "ACCEPT",
    require => [File["/etc/puppet/iptables/pre.iptables"], File["/etc/puppet/iptables/post.iptables"]],
    notify => Exec["save iptables rules"]
  }

  exec { "save iptables rules":
    command => "iptables-save > /etc/iptables.rules",
    refreshonly => true,
    require => File["/etc/network/if-pre-up.d/load-iptables"]
  }

  file { "/etc/network/if-pre-up.d/load-iptables":
    content => template("iptables/load-iptables"),
    owner => root,
    group => root,
    mode => 700
  }

  file { "/etc/puppet/iptables/pre.iptables":
    content => template("iptables/pre-iptables"),
    owner => root,
    group => root,
    require => File["/etc/puppet/iptables"]
  }

  file { "/etc/puppet/iptables/post.iptables":
    content => template("iptables/post-iptables"),
    owner => root,
    group => root,
    require => File["/etc/puppet/iptables"]
  }

  file { "/etc/puppet/iptables":
    ensure => directory
  }
}
