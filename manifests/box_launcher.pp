import "server/base/apt"
import "users/kevin"
import "project/chloe"


class box {

  class { 'apt': }

  class { 'kevin':
    require => Class['apt']
  }

  class { 'chloe':
    require => Class['kevin']
  }

  chloe::install_for { 'install_chloe_kevin':
    user    => 'kevin',
    require => Class['chloe'],
  }

	notice('Creating both kevin and the project')
}

include box
