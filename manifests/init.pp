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
    $version = $mockserver::params::version,
    $dir     = $mockserver::params::dir,
    $user    = $mockserver::params::user,
    $group   = $mockserver::params::group,

    # mockserver parameters
    $log_level   = $mockserver::params::settings['log_level'],
    $server_port = $mockserver::params::settings['server_port'],

    # service hash
    $service = $mockserver::params::service,

    # maven uri
    $uri     = $mockserver::params::uri,

    # jar file with mockserver-netty
    $file = "mockserver-netty-${version}-jar-with-dependencies.jar",

    # run parameters for mockserver
    $settings = $mockserver::params::settings,

) inherits mockserver::params {
    validate_legacy(Stdlib::Compat::Hash, 'validate_hash', $settings)
    validate_legacy(Stdlib::Compat::Hash, 'validate_hash', $service)

    class { 'mockserver::config': 
      service     => $service,
      settings    => $settings,
      uri         => $uri,
      version     => $version,
      file        => $file,
      user        => $user,
      group       => $group,
      dir         => $dir,
      log_dir     => $log_dir,
      log_level   => $log_level,
      server_port => $server_port,
    } ->
    class { 'mockserver::install': 
      dir     => $dir,
      file    => $file,
      version => $version,
    } ~>
    class { 'mockserver::service': } ->
    Class['mockserver']
}
