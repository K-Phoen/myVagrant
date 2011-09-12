import "../server/lamp"
import "../server/base/mysql"

class chloe {

  $chloe_host = "chloe.loc"


  include lamp

  mysql::db { "chloe_sf": }
  mysql::db { "chloe_sf_test": }

  define install_for ($user) {
    host { "host_chloe_${user}":
      ensure        => "present",
      ip            => "127.0.0.1",
      host_aliases  => $chloe_host,
    }

    apache2::sf_virtualhost { "chloe_${user}":
      host        => $chloe::chloe_host,
      projectroot => "/home/${user}/${chloe::chloe_host}",
    }

    exec { "clone_${user}":
      user    => $user,
      command => "git clone ssh://git@kphoen/chloe-sf.git ${chloe_host}",
      cwd     => "/home/${user}",
      creates => "/home/${user}/${chloe_host}",
      unless  => "test -d ${chloe_host}",
      path    => ["/bin", "/usr/bin", "/usr/local/bin", "/usr/sbin"],
      require => [User["${user}"], Package['git']],
    }
  }

  notice ("Creating project: chloe")
}
