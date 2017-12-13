# == Class: mockserver
#
# Mockserver is a java jar running under netty and is used for mocking soap test
#
# === Parameters ===
#
# * version
#   Version of Mockserver to install
# * log_level
#   Any of OFF, ERROR, WARN, INFO, DEBUG, TRACE or ALL
# * server_port
#   Port to run the service on, default 8411
# * dir
#   Directory to install mockserver in, default /opt/mockserver
# * user
#   User to run mockserver under, default mockserver
# * group
#   Group to assign to user, default mockserver
#
class mockserver (
    Hash   $versions    = $mockserver::params::version,
    String $install_dir = $mockserver::params::install_dir,
    String $user        = $mockserver::params::user,
    String $group       = $mockserver::params::group,
    String $log_dir     = $mockserver::params::log_dir,

    # mockserver parameters
    Enum['OFF', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE', 'ALL'] $log_level = $mockserver::params::settings['log_level'],

    # maven uri
    String $uri     = $mockserver::params::uri,

    # run parameters for mockserver
    Hash $settings = $mockserver::params::settings,

) inherits mockserver::params {

  File{
    owner => $user,
    group => $group
  }

  class {'java': }
  package { 'maven':
    ensure => installed,
  }
  class { 'mockserver::config::global':
    user        => $user,
    group       => $group,
    install_dir => $install_dir,
    log_dir     => $log_dir
  }
  class { 'mockserver::service': }
  $versions.each |String $version, Hash $params| {
    $file = "mockserver-netty-${version}-jar-with-dependencies.jar"

    mockserver::config {$version:
      ensure      => $params['ensure'],
      user        => $user,
      group       => $group,
      version     => $version,
      settings    => $settings,
      install_dir => $install_dir,
      log_dir     => $log_dir,
      log_level   => $log_level,
      server_port => $params['server_port'],
      file        => $file,
    }
    -> mockserver::install {$version:
      ensure      => $params['ensure'],
      version     => $version,
      install_dir => $install_dir,
    }
    -> mockserver::service::version {$version:
      ensure      => $params['ensure'],
      user        => $user,
      group       => $group,
      install_dir => $install_dir,
    }
    ~> Class['mockserver::service']
  }
}
