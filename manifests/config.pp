# == Class mockserver::config
#
# Create directories, user
#
class mockserver::config (
  $settings,
  $uri,
  $versions,
  $user,
  $group,
  $install_dir,
  $log_dir,
  $log_level,
  $server_port,
  ) {

  # check log_level
  if ! ($log_level in ['OFF', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE', 'ALL']) {
    fail ( "Wrong log_level: ${log_level}" )
  }

  File {
    owner => $user,
    group => $group,
  }

  # create user and groups
  user { $user:
    ensure     => present,
    home       => $install_dir,
    managehome => false,
    system     => false,
  }

  group { $group:
    ensure => present,
    system => false,
  }

  file { $install_dir:
    ensure => directory,
  }
  file { $log_dir:
    ensure => directory,
  }

  $versions.each |String $version| {
    file { "${install_dir}/${version}":
      ensure => directory,
    }
    file { "${install_dir}/${version}/bin":
      ensure => directory,
    }
    file { "${install_dir}/${version}/lib":
      ensure => directory,
    }

    file { "${install_dir}/${version}/bin/mockserver.sh":
      ensure  => file,
      content => template('mockserver/mockserver.sh.erb'),
      owner   => $user,
      group   => $group,
      mode    => '0755',
    }

    file { "${log_dir}/mockserver_${version}.log":
      ensure => file,
      owner  => $user,
      group  => $group,
    }
  }

  # wrapper for multiple instances
  file { 'mockserver_service':
    ensure  => file,
    content => template('mockserver/mockserver.service.erb'),
    path    => '/etc/systemd/system/mockserver.service',
    mode    => '0644',
    owner   => $user,
    group   => $group,
  }
}
