import "common"

class freerange {
  define user($password) {
    user {$name:
      ensure => present,
      home => "/home/$name",
      groups => admin,
      password => $password
    }

    replace {"set_${name}_password":
      file => "/etc/shadow",
      pattern => "$name\\:\\*",
      replacement => "$name:$password",
      require => User["$name"]
    }
    
    file {"/home/$name": 
      ensure => directory, 
      owner => $name,
      group => $name, 
      require => User["$name"]
    }

    file {"/home/$name/.ssh":
      ensure => directory,
      owner => $name,
      group => $name,
      require => User["$name"]
    }
  }
}