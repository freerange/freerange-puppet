class ufw {
  package { ["ufw"]:
    ensure => latest
  }

  exec { "enable-firewall":
    command => "/usr/bin/yes | /usr/sbin/ufw enable",
    unless => "/usr/sbin/ufw status | grep \"Status: active\"",
    require => [Package["ufw"]]
  }
  
  define allow() {
    exec {"ufw-allow-$name":
      require => Exec["enable-firewall"],
      command => "/usr/sbin/ufw allow \"$name\"",
      unless => "/usr/sbin/ufw status | grep \"$name.*ALLOW.*Anywhere\""
    }
  }
}