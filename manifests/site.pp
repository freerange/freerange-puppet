import 'common'
import 'ssh'

node default {
    package { "build-essential":
        ensure => installed
    }

    include ssh::server
    include ssh::client 
    
    user {"freerange":
        ensure => present,
        home => "/home/freerange"
    }
    
    file {"/home/freerange": 
        ensure => directory, 
        owner => freerange, 
        require => User["freerange"]
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