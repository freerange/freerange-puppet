class freerange {
  define user {
    user {$name:
      ensure => present,
      home => "/home/$name"
    }
    
    file {"/home/$name": 
      ensure => directory, 
      owner => $name,
      group => $name, 
      require => User["$name"]
    }
  }
}