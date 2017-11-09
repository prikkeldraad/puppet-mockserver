# == Class mockserver::config
#
# Create directories, user
#
class mockserver::config {
  # check log_level
  if ! ($mockserver::settings['log_level'] in ['OFF', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE', 'ALL']) {
    fail ( "Wrong log_level: ${mockserver::settings['log_level']}" )
  }

  $source = "${mockserver::uri}/${mockserver::version}/${mockserver::file}";

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
    ensure  => file,
    content => template('mockserver/mockserver.sh.erb'),
    owner   => $mockserver::user,
    group   => $mockserver::group,
    mode    => '0755',
  }

  file { "${mockserver::log_dir}":
    ensure => directory,
  }
  file { "${mockserver::log_dir}/mockserver.log":
    ensure => file,
    owner  => $mockserver::user,
    group  => $mockserver::group,
  }

  file { 'mockserver_service':
    ensure  => file,
    content => template($mockserver::service_template),
    path    => $mockserver::service_file,
    mode    => $mockserver::service_mode,
    owner   => $mockserver::user,
    group   => $mockserver::group,
  }
}
