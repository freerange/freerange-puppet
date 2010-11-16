class freerange {
  include zsh

  define user($user, $key, $key_type="ssh-rsa") {
    user_without_ssh_key { $name:
      user => $user
    }
    append_ssh_key_to_user { $name:
      user => $user,
      key => $key,
      key_type => $key_type
    }
    append_ssh_key_to_user { "freerange-$name":
      user => "freerange",
      key => $key,
      key_type => $key_type
    }
  }

  define user_without_ssh_key($user) {
    include base::application

    user {$user:
      gid => "application",
      require => User[application]
    }

    file { "/home/$user":
      ensure => directory,
      owner => $user,
      group => application,
      require => User[$user]
    }
  }

  define append_ssh_key_to_user($user, $key, $key_type="ssh-rsa") {
    ssh_authorized_key { $name:
      ensure => present,
      user => $user,
      key => $key,
      name => $name,
      type => $key_type
    }
  }
}
