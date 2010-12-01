class postfix {
  package { "postfix":
    ensure => present
  }

  service { "postfix":
    ensure => true,
    enable => true
  }

  file { "/etc/postfix/main.cf":
    content => template("postfix/main.cf"),
    notify => Service["postfix"],
    require => Package["postfix"]
  }
}
