class base {  
  file { "/etc/hosts":
    content => template("base/hosts"),
    owner => root,
    group => root
  }
}