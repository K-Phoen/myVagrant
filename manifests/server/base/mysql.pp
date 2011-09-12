class mysql {
  package { "mysql-server":
    ensure  => present,
  }

  service { "mysqld":
    ensure  => running,
    require => Package["mysql-server"],
  }

  define db( ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -uroot ${name}",
      command => "/usr/bin/mysql -uroot -e \"create database ${name};\"",
      require => Service["mysqld"],
    }
  }

  notice("Installing MySQL")
}
