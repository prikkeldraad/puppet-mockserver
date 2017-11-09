# == Class mockserver::install
#
# Install mockserver-netty-with-dependencies
# Install java
#
class mockserver::install {
  maven { "${mockserver::dir}/lib/${mockserver::file}":
    id    => "org.mock-server:mockserver-netty:${mockserver::version}:jar:jar-with-dependencies",
    repos => ["central::default::http://https://repo1.maven.org/maven2/"],
  }

  class { 'java':}
}
