node default {
  include multiverse, ufw, monit, ntp, ssh::server, ssh::client, zsh
  include ruby, puppet, git, bundler
  
  package { 
    "build-essential":; 
    "makepasswd":;
  }

  freerange::user {"freerange":
    password => "\$6\$aYTNVUiw\$gldwlZGC1I7tO3iG0xvbJuDcgc6Irx60Fr5DfQBeKzLRBdL1AeHfeZv/oXZ0fZJ5WzQP9tUhbM9YR3OZWjZgJ/"
  }
  
  ssh_authorized_key {"tom@popdog.net":
    ensure => present,
    user => freerange,
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA7wy/hGcJZ1PFRCjs0UKIrALs+zm0d2+fVtHJqCdWTOOOaP3NRUEsi5Eb60vzuTkgEilcOhIT9jMUMCUzKHbqlG6EMhXFOsyaNDV30oyj9pHYeqUDCY52vb9GXTejFEFAy4bnlG+5N//B8nXiGuOjTWJdXuDhhvFSO1Cqp9doDQLfgnfP8pUmquVHYVN7aOIjIMlmnhXedLOAWhmfNaaA6IrbsqEqRAqe+YqRtB25Kqh4UCd8Fjd7dh98W32TrLtlh8qtb8e7U3W+lskpnbDubcptQKAdzbKDFpdpPQKGMtrCnPx3rnddZWH2dV36smm+IwwUbrjH3U/1F2ci8aCgFQ==",
    name => "tom@popdog.net",
    target => "/home/freerange/.ssh/authorized_keys",
    type => ssh-rsa,
    require => File["/home/freerange"],
  }
  
  ssh_authorized_key {"jasoncale@Jase.local":
    ensure => present,
    user => freerange,
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA1O1lXgJcBenQ14N4S32J+m9q3HG1UY7gd+keXtFtZhMSvcByMNIcMREdXetC0XgeoTamybfK5+k8t18+oKX1E6zsUEzF2hYua52n8ZKH5Szsh/Gk7WLtsC6r7THC1yx0gihAt8FzFldzUAsFaYQIwBP514acQ1VqS+TDJltMSw8a31Z1t7LgeAWSPwj3A2meSxVdWDbAJ4n9tnGUTkCWZSm8AEUlRwSfU2lEPYvRtuKpcFllrK4f0kNBvKFWlXMCtU8MCHPJkq0DYxlf0YFOZooRpLMhIQojMmTKRwZI532miN2CF/Co2t8W7YBHhCwBmaG24Z5MybiByCaBwyBy8w==",
    name => "jasoncale@Jase.local",
    target => "/home/freerange/.ssh/authorized_keys",
    type => ssh-rsa,
    require => File["/home/freerange"],
  }
  
  ssh_authorized_key {"jamesmead@MacBookPro5.local":
    ensure => present,
    user => freerange,
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA2sgFVWa22MUpTC3d7rn04qhzLRc5CwwuBLGp3dm3Yg5mFpq2dQLMlWZN/uK4SK1DC8fEDCbnaq4iGUk1VAUt6tN8UxrR9P5yrxSWTLLwanpNb/G6I4sRbzJaowhEchPLvoTWpege6hX6xGzHJRspODxT+Dhhrx8RIT5ZU19IlMEzSpYXNtBk5P+poj3AwC4gBwGhtC/B/YltM6Cxpi6Tp1Jb7vilRW08GU8EkmiBhs45QF2wWV2+OMinW7QIww7c6NdrbIDWw9+FBGOUHRlyPpXMCuz8B1zgplzoFLlO13r2fPDx2pB8WodMkZie28s1tfLB4gKIHVWbf9YYyLQeTQ==",
    name => "jamesmead@MacBookPro5.local",
    target => "/home/freerange/.ssh/authorized_keys",
    type => ssh-rsa,
    require => File["/home/freerange"],
  }

  ssh_authorized_key {"james@lazyatom.com":
    ensure => present,
    user => freerange,
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA2hsOv1phLQ6OsNMSLWMoXmV2q4qcaOZy6EDsX7+89WX1BQ/iCRckdvwhCc+KTYbIcCZA91JFhXtVwQ3tKDrJbdSYwTg3Y2a4dakbK87H63s7z5oIuM1KWXHGRV4RQGwqIgxNqkEwRUdbYkZ+Ct8X2W7bLTBkLA3zhOT7etxyg8WXRjGUdP6rpnAoJzVbnrn36SDKkWs+6yp5aNDhU4929En/8logAgBD3ByMAg9f/ndbVNA34ZuLWp6LYo2lZDrNxuAE4caseht+ovBWGiq84MmIMpVMuF0HuNNSh24CA8cF2DB7r+vYcmjHBz4VY7u4wkXBsPIbOjVwXVls5F7Hnw==",
    name => "james@lazyatom.com",
    target => "/home/freerange/.ssh/authorized_keys",
    type => ssh-rsa,
    require => File["/home/freerange"],
  }
  
  ssh_authorized_key {"kalv@kalv-macbook.config":
    ensure => present,
    user => freerange,
    key => "AAAAB3NzaC1kc3MAAACBAIJ5jkXnd3XEcbSHVQ1RyCDfObE4efz1wfexP73/3RWEtIpmL9PsbVm57YMzpwU9ct94/RoHiNBIDr66gnfIdWnIVctjiZTZjTrolbWVSPgVq8RldNpVCDOJISKAoXAPWPTc9NuweTLxFIre9vVWY8Jkvz3AMrRubjcXUsc2NuKpAAAAFQCp8GdX6JUcnzjMvdcf39kUtHz6wwAAAIBwDchJvc87IGIK0p4ddCC0k59Tkre5xbUTEIUmyyUUaijPJQwR6gG86DMFNbrvkE0LJYy8lnVZ9mtAafHeC7zaiziYBUrBSQzVKf0cBjKy7WToCGE/FoAh28T3RomAamFeL31Fh7tXydHvf29UxME5MM0qOQaxSNmJ0ssPzY8jpwAAAIAeHG/4oUmOlwrqrOssK/jTNuYAdViVJxRMn7SzgHZ+tsjqoI5Gh1JvGGVMgI7zfKGZHDwyKjLY3+j0Yl29jtOLTgQmMzDFpOazScBNODehHKLDa1ILQ4zAiXsf9v4JO5vRGO0S9tuD+CvbBQp+r9CeLb2OxOIVfJMaAXkEONG9bw==",
    name => " kalv@kalv-macbook.config",
    target => "/home/freerange/.ssh/authorized_keys",
    type => ssh-dss,
    require => File["/home/freerange"],
  }
}
