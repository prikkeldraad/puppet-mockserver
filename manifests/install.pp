# == Class mockserver::install
#
# Install mockserver-netty-with-dependencies
# Install java
#
define mockserver::install (
  $ensure,
  $version,
  $install_dir,
  $file,
  ){

  case $ensure {
    present: {
      maven { "${install_dir}/${version}/lib/${file}":
        id    => "org.mock-server:mockserver-netty:${version}:jar:jar-with-dependencies",
        repos => ['central::default::http://https://repo1.maven.org/maven2/'],
      }
    }
    default: {
      file { "${install_dir}/${version}/lib/${file}": ensure => absent }
    }
  }
}
