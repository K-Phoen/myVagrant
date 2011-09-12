import "base/ssh_utils"

class kevin {

  $username = "kevin"


  file { "ssh_dir_${username}":
    path    => "/home/${username}/.ssh",
    ensure  => directory,
    owner   => $username,
    group   => $username,
  }

  ssh_utils::config { "${username}_ssh_config":
    owner     => $username,
    require   => File["ssh_dir_${username}"],
  }
  ssh_utils::key { "${username}_nopass_dev":
    owner     => $username,
    key       => 'kphoen_dev_git_no_passphrase',
    require   => File["ssh_dir_${username}"],
  }

  package { ["exuberant-ctags", "zsh", "git", "vim"]:
    ensure  => latest,
  }

  user { "${username}":
    ensure     => "present",
    groups     => ["www-data"],
    shell      => "/bin/zsh",
    managehome => true,
    password   => '$6$nhLKXeuK$0sWmz86iYmyT1mdSHR5c4lOmoIi3rbjsG0rjhc2ldhNSla9S2a1W/1wJdrFttWcO4y55uqGAkDnasPgFe03hC0',
  }

  exec { "dotfiles-install":
    user    => $username,
    cwd     => "/home/${username}",
    command => "git clone git://github.com/K-Phoen/Config.git && cd Config && git submodule update --init && ./install_all.sh",
    unless  => "test -d Config",
    path    => ["/bin", "/usr/bin", "/usr/local/bin", "/usr/sbin"],
    require => [Package['git'], Ssh_utils::Key["${username}_nopass_dev"]],
  }

  exec { "dotfiles-update":
    user    => $username,
    cwd     => "/home/${username}/Config",
    command => "git pull origin master && git submodule update --init && ./install_all.sh",
    onlyif  => "test -d Config",
    path    => ["/bin", "/usr/bin", "/usr/local/bin", "/usr/sbin"],
    require => Exec['dotfiles-install'],
  }

  notice ("Creating user: ${username}")
}
