class logrotate {
  package { "logrotate":
    ensure => installed
  }

  file { "/etc/logrotate.d":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755,
    require => Package["logrotate"]
  }

  define rotate_file($source = false, $log = false, $options = false, $prerotate="NONE", $postrotate="NONE") {
    # $options should be an array containing 1 or more logrotate directives (e.g. missingok, compress)
    include logrotate

    if $source {
      file { "/etc/logrotate.d/${name}":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => $source,
        require => File["/etc/logrotate.d"]
      }
    } else {
      file { "/etc/logrotate.d/${name}":
        owner   => root,
        group   => root,
        mode    => 644,
        content => template("logrotate/logrotate.erb"),
        require => File["/etc/logrotate.d"]
      }
    }
  }
}

