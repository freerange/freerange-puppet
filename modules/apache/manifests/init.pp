class apache {
    package {
        "apache2-mpm-prefork":
            ensure => installed;
        "apache2-prefork-dev":
            ensure => installed;
        "libapr1-dev":
            ensure => installed;
        "libaprutil1-dev":
            ensure => installed;
    }
    
    service { "apache2": require => Package["libaprutil1-dev", "libapr1-dev", "apache2-mpm-prefork", "libapr1-dev"] }
}