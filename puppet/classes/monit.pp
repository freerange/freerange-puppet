class monit {
  package {"monit":
    ensure => present
  }
  
  file { "/etc/monit.conf":
    content => template("monit/monit.conf"),
    owner => root,
    group => root,
    mode => 700,
    require => Package[monit],
    notify => Service[monit]
  }

  service { "monit": 
    require => [Package["monit"], File["/etc/monit.conf"]],
    ensure => running
  }

  define config($content, $user=false) {
    if $user {
      file { "/etc/monit.d/$name.conf":
        content => $content,
        require => [Package[monit], User[$user]],
        notify => Service[monit]
      }
    } else {
      file { "/etc/monit.d/$name.conf":
        content => $content,
        require => Package[monit],
        notify => Service[monit]
      }
    }
  }
}
