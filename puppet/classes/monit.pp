class monit {
  package {"monit":
    ensure => present
  }
  
  file { "/etc/monit.conf":
    content => template("monit/monit.conf"),
    owner => root,
    group => root,
    mode => 700
  }
  
  service { "monit": 
    require => [Package["monit"], File["/etc/monit.conf"]],
    ensure => running
  }

  define config($content) {
    file { "/etc/monit.d/$name.conf":
      content => $content
    }
  }
}
