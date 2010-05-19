node default {
  include ufw, monit, ntp, ssh::server, ssh::client, zsh
  include ruby, puppet, git, bundler
  
  package { "build-essential":
    ensure => installed
  }

  freerange::user {"freerange":
    password => "\\\$6\\\$OzfJiUna\\\$RsaOsmqSWzq/sqMTL8Epy1nojIFYf1Rb178dx/QSo54cD2RmVcN7BmBx5d9WnFyb0hocKOjA1NIaUl0Xo08QX0"
  }
  
  ssh_authorized_key {"tom@popdog.net":
    ensure => present,
    user => freerange,
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA7wy/hGcJZ1PFRCjs0UKIrALs+zm0d2+fVtHJqCdWTOOOaP3NRUEsi5Eb60vzuTkgEilcOhIT9jMUMCUzKHbqlG6EMhXFOsyaNDV30oyj9pHYeqUDCY52vb9GXTejFEFAy4bnlG+5N//B8nXiGuOjTWJdXuDhhvFSO1Cqp9doDQLfgnfP8pUmquVHYVN7aOIjIMlmnhXedLOAWhmfNaaA6IrbsqEqRAqe+YqRtB25Kqh4UCd8Fjd7dh98W32TrLtlh8qtb8e7U3W+lskpnbDubcptQKAdzbKDFpdpPQKGMtrCnPx3rnddZWH2dV36smm+IwwUbrjH3U/1F2ci8aCgFQ==",
    name => "tomw@popdog.net",
    target => "/home/freerange/.ssh/authorized_keys",
    type => rsa,
    require => File["/home/freerange"],
  }

  ssh_authorized_key {"deploy@gofreerange.com":
    ensure => present,
    user => freerange,
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAuTgZ+wS8YJUmB6c+F8QimQh/xZuWPYa3fXmLDw2kp8S2cAf6XqU5Fuod/wrhlBdzGTjJdRm3CMWdCUDrh/D68Op8uaIqf/h78eLcVkC7DL3SfFqFxZ/IpQsUXEiFII5rjz2y3orLvUABuIJkuY72DoWhcn6Y0j8uy/wg94QXWKfLdPZTE4kBokO2QmLB+WYsoPAWdaUpswplfidhN1WwQWVHSV7Nfh2Tnym4rMXG61O7mYrFTRKEx5o3eSb9USBj2bEGVo+Nj8YWgNQK4+jxvmQ27kuMhF2C/4rQEXNqcPJnQa9gDpEQttfP8ZW0LNemvfNM/J6Mw05fcPvF5iAigw==",
    name => "deploy@gofreerange.com",
    target => "/home/freerange/.ssh/authorized_keys",
    type => rsa,
    require => File["/home/freerange"],
  }
}
