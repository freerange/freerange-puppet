class apt {
  exec {"apt-get update":
    command => "/usr/bin/apt-get -y update"
  }
}