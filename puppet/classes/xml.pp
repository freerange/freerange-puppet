class xml {
  include "xml::$operatingsystem"

  class ubuntu {
    package { "libxml2-dev":
      ensure => present
    }

    package { "libxslt1-dev":
      ensure => present
    }
  }

  class centos {
    package { "libxml2-devel":
      ensure => present
    }

    package { "libxslt-devel":
      ensure => present
    }
  }
}