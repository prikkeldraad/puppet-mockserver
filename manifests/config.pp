# == Class mockserver::config
#
# Create directories, user
#
class mockserver::config (
  #$name,
  $settings,
  $uri,
  $version,
  $file,
  $user,
  $group,
  $dir,
  $log_dir,
  $log_level,
  $server_port,
  ) {

  # check log_level
  if ! ($log_level in ['OFF', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE', 'ALL']) {
    fail ( "Wrong log_level: ${log_level}" )
  }

  $source = "${uri}/${version}/${file}";

  File {
    owner => $user,
    group => $group,
  }

  # create user and groups
  user { $user:
    ensure     => present,
    home       => $dir,
    managehome => false,
    system     => false,
  }

  group { $group:
    ensure => present,
    system => false,
  }

  file { $dir:
    ensure => directory,
  }
  file { "${dir}/${version}":
    ensure => directory,
  }
  file { "${dir}/${version}/bin":
    ensure => directory,
  }
  file { "${dir}/${version}/lib":
    ensure => directory,
  }

  file { "${dir}/${version}/bin/mockserver.sh":
    ensure  => file,
    content => template('mockserver/mockserver.sh.erb'),
    owner   => $user,
    group   => $group,
    mode    => '0755',
  }

  file { "${log_dir}":
    ensure => directory,
  }
  file { "${log_dir}/mockserver_${version}.log":
    ensure => file,
    owner  => $user,
    group  => $group,
  }

  # config service
  case $facts['os']['family'] {
    'Redhat': {
      $shell = '/sbin/nologin'

      case $facts['os']['release']['major'] {
        '7' : {
          $service_file     = "/usr/lib/systemd/system/mockserver@${version}.service"
          $service_template = 'mockserver/mockserver@.service.erb'
          $service_mode     = '0644'
        }

        default: {
          fail( "${facts['os']['family']} ${facts['os']['release']['major']} is not supported" )
        }
      }
    }

    default: {
      fail ( "${facts['os']['family']} is not supported" )
    }
  }

  $service = {
    'name'     => "mockserver@${version}",
    'file'     => $service_file,
    'template' => $service_template,
    'mode'     => $service_mode,
  }

  file { 'mockserver@_service':
    ensure  => file,
    content => template($service['template']),
    path    => $service['file'],
    mode    => $service['mode'],
    owner   => $user,
    group   => $group,
  }

  # wrapper for multiple instances
  file { 'mockserver_service':
    ensure  => file,
    content => template('mockserver/mockserver.service.erb'),
    path    => '/usr/lib/systemd/system/mockserver.service',
    mode    => '0644',
    owner   => $user,
    group   => $group,
  }
}
