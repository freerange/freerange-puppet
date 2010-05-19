class rubygems {
  include ruby
  
  package { "rubygems-update":
    ensure => "1.3.6",
    provider => "gem",
    notify => Exec["update rubygems"],
    require => Class["ruby"]
  }
  
  exec { "update rubygems":
    path => "/usr/bin:/var/lib/gems/1.8/bin",
    command => "update_rubygems",
    refreshonly => true
  }
}