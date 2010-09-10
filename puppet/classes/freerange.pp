class freerange {
  include zsh

  user {"freerange":
    shell => "/bin/false"
  }
  
  user {"tomw":
    shell => "/bin/zsh",
    groups => "freerange"
  }
}