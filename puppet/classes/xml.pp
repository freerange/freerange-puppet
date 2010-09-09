class xml {
  package { "libxml2-devel": 
    ensure => present
  }
  
  package { "libxslt-devel":
    ensure => present
  }
}