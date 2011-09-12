import "base/*"

class lamp {
  class { 'apache2':
    require => Class['apt'], # to get dotdeb's packages
  }

  class { 'mysql':
    require => Class['apt'], # to get dotdeb's packages
  }

  class { 'php5':
    require => Class['apache2'],
  }

  notice("Configuring base LAMP server")
}
