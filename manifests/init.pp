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
    Array  $version     = $mockserver::params::version,
    String $install_dir = $mockserver::params::install_dir,
    String $user        = $mockserver::params::user,
    String $group       = $mockserver::params::group,
    String $log_dir     = $mockserver::params::log_dir,

    # mockserver parameters
    String  $log_level   = $mockserver::params::settings['log_level'],
    Integer $server_port = $mockserver::params::settings['server_port'],

    # maven uri
    String $uri     = $mockserver::params::uri,

    # run parameters for mockserver
    Hash $settings = $mockserver::params::settings,

) inherits mockserver::params {

    class {'java': }
    class { 'mockserver::config':
      name        => $name,
      settings    => $settings,
      uri         => $uri,
      versions    => $version,
      user        => $user,
      group       => $group,
      install_dir => $install_dir,
      log_dir     => $log_dir,
      log_level   => $log_level,
      server_port => $server_port,
    }
    -> mockserver::install {$version:
      install_dir => $install_dir,
    }
    -> class { 'mockserver::service': }
    mockserver::service::version {$version:
      user  => $user,
      group => $group,
    }
}
