# == Class mockserver::install
#
# Install mockserver-netty-with-dependencies
# Install java
#
class mockserver::install (
  $dir,
  $file,
  $version,
  ){

  maven { "${dir}/${version}/lib/${file}":
    id    => "org.mock-server:mockserver-netty:${version}:jar:jar-with-dependencies",
    repos => ["central::default::http://https://repo1.maven.org/maven2/"],
  }

  class { 'java':}
}
