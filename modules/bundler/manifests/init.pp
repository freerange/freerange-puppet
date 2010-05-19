class bundler {
  include rubygems
  
  package {"bundler":
    ensure => "0.9.25",
    provider => "gem",
    require => Class["rubygems"]
  }
}