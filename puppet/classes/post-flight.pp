stage { "post-flight": require => Stage[main] }
class { "post-flight": stage => "post-flight" }

class post-flight {
  exec { "application group ownership":
    command => "chgrp -R application /var/apps",
    require => File["/var/apps"]
  }
  exec { "application sticky bit":
    command => "chmod -R g+rwxs /var/apps",
    require => File["/var/apps"]
  }
  exec { "application permissions":
    command => "chmod -R g+rww /var/apps",
    require => File["/var/apps"]
  }
}
