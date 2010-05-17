class ssh::common {
	file { "/etc/ssh":
		ensure => directory,
		mode => 0755, owner => root, group => root,
	}
	
	group { "ssh":
		gid => 204,
		allowdupe => false,
	}
}

class ssh::client inherits ssh::common {
	package {
		"openssh-client":
			ensure => installed,
			require => [ File["/etc/ssh"], Group[ssh] ],
	}

	# this is needed because the gid might have changed
	file { 
	  "/usr/bin/ssh-agent":
			group => ssh,
			require => Package[openssh-client];
		"/etc/ssh/ssh_known_hosts":
			mode => 0644, owner => root, group => 0;
	}
}

class ssh::server inherits ssh::common {
  include ufw
  include monit

  package { "openssh-server":
  	ensure => installed,
    require => [ File["/etc/ssh"], User[sshd] ],
  }
  
  user { "sshd":
  	uid => 204, gid => 65534,
  	home => "/var/run/sshd",
  	shell => "/usr/sbin/nologin",
    allowdupe => false,
  }

  file { "sshd_config":
    path => "/etc/ssh/sshd_config",
    owner => root,
    group => root,
    source => "/etc/puppet/modules/ssh/files/sshd_config"
  }

  service { "ssh":
  	ensure => running,
  	pattern => "sshd",
  	require => Package["openssh-server"],
    subscribe => [ User[sshd], Group["ssh"], File["sshd_config"] ]
  }
  
  ufw::allow { "OpenSSH":
    require => Package["openssh-server"]
  }
  
  file { "/etc/monit.d/sshd.monit": 
    ensure => present,
    source => "/etc/puppet/modules/ssh/files/sshd.monit",
    owner => root,
    group => root,
    notify => Service["monit"]
  }
}