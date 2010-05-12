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
      pattern => "$name\\:[\\!\\*]",
      replacement => "$name:$password",
      require => User["$name"]
    }
    
    file {"/home/$name": 
      ensure => directory, 
      owner => $name,
      group => $name, 
      require => User["$name"]
    }

    file {"/home/$name/.zsh":
      ensure => directory,
      owner => $name,
      group => $name,
      recurse => true,
      source => "/etc/puppet/modules/freerange/files/zsh",
      require => File["/home/$name"]
    }

    file {"/home/$name/.zshrc":
      owner => $name,
      group => $name,
      content => "source ~/.zsh/base.zsh"
    }

    file {"/home/$name/.ssh":
      ensure => directory,
      owner => $name,
      group => $name,
      require => User["$name"]
    }

    file {"/home/$name/.ssh/known_hosts":
      ensure => present,
      owner => $name,
      group => $name,
      require => File["/home/$name/.ssh"]
    }
  }
}