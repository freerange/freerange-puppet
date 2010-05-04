class ssh::common {
	file {
		"/etc/ssh":
			ensure => directory,
			mode => 0755, owner => root, group => root,
	}
	group {
		ssh:
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
    package {
    	"openssh-server":
    	    ensure => installed,
            require => [ File["/etc/ssh"], User[sshd] ],
    }
    
    user {
    	sshd:
    		uid => 204, gid => 65534,
    		home => "/var/run/sshd",
    		shell => "/usr/sbin/nologin",
            allowdupe => false,
    }

    service {
    	ssh:
    	    ensure => running,
    	    pattern => "sshd",
    	    require => Package["openssh-server"],
    	    subscribe => [ User[sshd], Group["ssh"] ]
    }
}