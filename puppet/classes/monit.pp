class monit {
  package {"monit":
    ensure => present
  }

  file { "/etc/default/monit":
    content => "startup=1"
  }
  
  file { "/etc/monit/monitrc":
    content => template("monit/monit.conf"),
    owner => root,
    group => root,
    mode => 700,
    require => Package[monit],
    notify => Service[monit]
  }

  service { "monit": 
    require => [Package["monit"], File["/etc/monit/monitrc"], File["/etc/default/monit"]],
    ensure => running
  }

  define config($content, $user=false) {
    if $user {
      file { "/etc/monit/conf.d/$name.conf":
        content => $content,
        require => [Package[monit], User[$user]],
        notify => Service[monit]
      }
    } else {
      file { "/etc/monit/conf.d/$name.conf":
        content => $content,
        require => Package[monit],
        notify => Service[monit]
      }
    }
  }
}
