# == Class: mockserver::config::global
# Author: Siebren Zwerver
#

class mockserver::config::global (
  $user,
  $group,
  $install_dir,
  $log_dir,
  ) {

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
