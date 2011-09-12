class php5 {
  package {
    [
      "php5",
      "php5-cli",
      "php5-mysql",
      "php5-gd",
      "php5-mcrypt",
      "php-pear",
      "php5-xdebug",
      "php5-sqlite",
      "php5-intl",
      "php5-xsl",
      "php5-apc"
    ]: ensure => present,
  }

  notice("Installing PHP")
}
