node default {
  package { "build-essential":
    ensure => installed
  }

  include zsh
  include ssh::server
  include ssh::client 
  
  freerange::user {"freerange":
    password => "\\\$6\\\$OzfJiUna\\\$RsaOsmqSWzq/sqMTL8Epy1nojIFYf1Rb178dx/QSo54cD2RmVcN7BmBx5d9WnFyb0hocKOjA1NIaUl0Xo08QX0"
  }

  freerange::user {"tomw":
     password => "\\\$6\\\$OzfJiUna\\\$RsaOsmqSWzq/sqMTL8Epy1nojIFYf1Rb178dx/QSo54cD2RmVcN7BmBx5d9WnFyb0hocKOjA1NIaUl0Xo08QX0"
   }
  
  package { "bundler":
    ensure => "0.9.25",
    provider => "gem"
  }
  
  ssh_authorized_key {"tom@popdog.net":
    ensure => present,
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA7wy/hGcJZ1PFRCjs0UKIrALs+zm0d2+fVtHJqCdWTOOOaP3NRUEsi5Eb60vzuTkgEilcOhIT9jMUMCUzKHbqlG6EMhXFOsyaNDV30oyj9pHYeqUDCY52vb9GXTejFEFAy4bnlG+5N//B8nXiGuOjTWJdXuDhhvFSO1Cqp9doDQLfgnfP8pUmquVHYVN7aOIjIMlmnhXedLOAWhmfNaaA6IrbsqEqRAqe+YqRtB25Kqh4UCd8Fjd7dh98W32TrLtlh8qtb8e7U3W+lskpnbDubcptQKAdzbKDFpdpPQKGMtrCnPx3rnddZWH2dV36smm+IwwUbrjH3U/1F2ci8aCgFQ==",
    name => "tomw@popdog.net",
    target => "/home/freerange/.ssh/authorized_keys",
    type => rsa,
    require => File["/home/freerange"],
  }
}
