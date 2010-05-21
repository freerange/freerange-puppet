User {
  shell => "/usr/bin/zsh"
}

Exec {
  path => "/usr/bin:/usr/sbin:/bin"
}

Package {
  ensure => installed
}