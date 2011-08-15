class developer {
  package { ["git-core", "vim-nox"]:
    ensure  => latest,
  }
}
