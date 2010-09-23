class munin {
  package {"munin":
    ensure => present
  }

  package {"munin-node":
    ensure => present,
    require => Package["munin"]
  }

  service {"munin-node":
    require => Package["munin-node"],
    ensure => running,
    enable => true
  }

  package {"request-log-analyzer":
    ensure => present,
    provider => gem
  }

  define rails($log) {
    include munin

    munin::plugin {"$name-rails-requests":
      config => template("munin/rails-plugin-config"),
      content => template("munin/plugins/rails_requests")
    }

    munin::plugin {"$name-rails-request-duration":
      config => template("munin/rails-plugin-config"),
      content => template("munin/plugins/rails_request_duration")
    }

    munin::plugin {"$name-rails-request-error":
      config => template("munin/rails-plugin-config"),
      content => template("munin/plugins/rails_request_error")
    }

    munin::plugin {"$name-rails-view-render-time":
      config => template("munin/rails-plugin-config"),
      content => template("munin/plugins/rails_view_render_time")
    }
  }

  define plugin($config, $content) {
    file {"/etc/munin/plugins/$name":
      content => $content,
      mode => 777
    }

    file {"/etc/munin/plugin-conf.d/$name":
      content => "[$name]\n$config",
      notify => service["munin-node"]
    }
  }
}