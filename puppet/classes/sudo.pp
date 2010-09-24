class sudo {

  $content = template("sudo/sudoers")
  file { "/etc/sudoers":
    owner => "root",
    group => "root",
    mode  => 440,
    content => $content
  }

  file { "/etc/sudoers.d":
    ensure => directory,
    owner => root,
    group => root
  }

  define allow_command($command, $group) {
    file { "/etc/sudoers.d/$name":
      content => "%$group ALL=NOPASSWD: $command\n",
      mode  => 440,
      require => [File["/etc/sudoers"], File["/etc/sudoers.d"]]
    }
  }
}