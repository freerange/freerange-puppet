# wget http://apt.brightbox.net/release.asc -O - | apt-key add -
# echo "deb http://apt.brightbox.net/ lucid rubyee" > 
# 
# 
class ruby {
  include rubygems
  
  file {"brightbox":
    path => "/etc/apt/sources.list.d/brightbox-rubyee.list",
    ensure => present,
    owner => root,
    group => root,
    content => "deb http://apt.brightbox.net/ lucid rubyee",
    notify => Exec["update apt"]
  }
  
  exec {"brightbox":
    command => "/usr/bin/wget http://apt.brightbox.net/release.asc -O - | /usr/bin/apt-key add -",
    unless => "/usr/bin/apt-key list | /bin/grep Brightbox",
    notify => Exec["update apt"]
  }
  
  exec {"update apt":
    command => "/usr/bin/apt-get update",
    refreshonly => true  
  }  
  
  package {["rdoc", "ruby", "irb", "rubygems", "libopenssl-ruby", "irb1.8", "libruby1.8", "libopenssl-ruby1.8", "libreadline-ruby1.8", "ruby1.8", "rdoc1.8", "ruby1.8-dev"]:
    ensure => latest,
    require => [File["brightbox"], Exec["brightbox"]]
  }
}