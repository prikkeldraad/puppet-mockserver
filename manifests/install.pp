# == Class mockserver::install
#
# Install mockserver-netty-with-dependencies
# Install java
#
define mockserver::install (
  $install_dir,
  ){

  $version = $title
  $file = "mockserver-netty-${version}-jar-with-dependencies.jar"

  maven { "${install_dir}/${version}/lib/${file}":
    id    => "org.mock-server:mockserver-netty:${version}:jar:jar-with-dependencies",
    repos => ['central::default::http://https://repo1.maven.org/maven2/'],
  }
}
