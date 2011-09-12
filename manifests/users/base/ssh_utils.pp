class ssh_utils {
  define config ($owner) {
    file { "ssh_config_${owner}":
      path    => "/home/${owner}/.ssh/config",
      ensure  => present,
      source  => "/mnt/ssh_keys/config",
      force   => true,
      owner   => $owner,
      group   => $owner,
    }

    file { "ssh_known_hosts_${owner}":
      path    => "/home/${owner}/.ssh/known_hosts",
      ensure  => present,
      source  => "/vagrant/files/known_hosts",
      force   => true,
      owner   => $owner,
      group   => $owner,
    }
  }

  define key ($owner, $key) {
    file { "ssh_key_${key}":
      path    => "/home/${owner}/.ssh/${key}",
      ensure  => present,
      source  => "/mnt/ssh_keys/${key}",
      force   => true,
      owner   => $owner,
      group   => $owner,
      mode    => 600,
    }
    
    file { "ssh_pubkey_${key}":
      path    => "/home/${owner}/.ssh/${key}.pub",
      ensure  => present,
      source  => "/mnt/ssh_keys/${key}.pub",
      force   => true,
      owner   => $owner,
      group   => $owner,
      mode    => 600,
      require => File["ssh_key_${key}"],
    }

    notice("Adding public and private key: ${key}")
  }
}
