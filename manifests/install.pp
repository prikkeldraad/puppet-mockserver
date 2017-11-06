#
class mockserver::install {
  $file   = "mockserver-netty-${mockserver::version}-jar-with-dependencies.jar";
  $source = "${mockserver::uri}/${mockserver::version}/${file}";

  File {
    owner => $mockserver::user,
    group => $mockserver::group,
  }

  # create user and groups
  user { $mockserver::user:
    ensure     => present,
    home       => $mockserver::dir,
    managehome => false,
    system     => false,
  }

  group { $mockserver::group:
    ensure => present,
    system => false,
  }

  file { $mockserver::dir:
    ensure => directory,
  }
  file { "${mockserver::dir}/bin":
    ensure => directory,
  }
  file { "${mockserver::dir}/lib":
    ensure => directory,
  }

  file { "${mockserver::dir}/bin/mockserver.sh":
    ensure  => 'file',
    content => template('mockserver/mockserver.sh.erb'),
    owner   => $mockserver::user,
    group   => $mockserver::group,
    mode    => '0755',
  }

  file { "/var/log/mockserver":
    ensure => directory,
  }
  file { "/var/log/mockserver/mockserver.log":
    ensure => 'file',
    owner  => $mockserver::user,
    group  => $mockserver::group,
  }

  maven { "${mockserver::dir}/lib/${file}":
    id    => "org.mock-server:mockserver-netty:${mockserver::version}:jar:jar-with-dependencies",
    repos => ["central::default::http://https://repo1.maven.org/maven2/"],
  }

  class { 'java':}
}
