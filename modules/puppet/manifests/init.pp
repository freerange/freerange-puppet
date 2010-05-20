class puppet {
  include ruby
  
  package {"puppet-pkg":
    source => "puppet",
    ensure => absent
  }
  
  package {"puppet":
    ensure => '0.25.5',
    provider => 'gem',
    require => [[Class["ruby"], Package["puppet-pkg"]]]
  }
}