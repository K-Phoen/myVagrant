class kevin inherits developer {
  package { ["exuberant-ctags", "zsh"]:
    ensure  => latest,
  }

  user { "kevin":
    ensure     => "present",
    groups     => ["www-data"],
    shell      => "/bin/bash",
    managehome => true,
    password   => '$6$nhLKXeuK$0sWmz86iYmyT1mdSHR5c4lOmoIi3rbjsG0rjhc2ldhNSla9S2a1W/1wJdrFttWcO4y55uqGAkDnasPgFe03hC0',
  }

  exec { "dotfiles-install":
    user    => kevin,
    cwd     => "/home/kevin",
    command => "git clone git://github.com/K-Phoen/Config.git && cd Config && git submodule update --init && ./install_all.sh",
    unless  => "test -d Config",
    path    => ["/bin", "/usr/bin", "/usr/local/bin", "/usr/sbin"],
    require => User["kevin"],
  }

  exec { "dotfiles-update":
    user    => kevin,
    cwd     => "/home/kevin/Config",
    command => "git pull origin master && git submodule update --init && ./install_all.sh",
    onlyif  => "test -d Config",
    path    => ["/bin", "/usr/bin", "/usr/local/bin", "/usr/sbin"],
    require => User["kevin"],
  }

  notice ("Creating user: kevin")
}
