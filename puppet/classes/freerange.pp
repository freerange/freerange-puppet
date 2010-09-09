class freerange {
  include zsh
  
  group {"hashblue":
    ensure => present
  }
  
  user {"hashblue":
    require => Group["hashblue"],
    shell => "/bin/false",
    groups => "hashblue"
  }
  
  user {"tomw":
    require => Group["hashblue"],
    shell => "/bin/zsh",
    groups => "hashblue"
  }
}