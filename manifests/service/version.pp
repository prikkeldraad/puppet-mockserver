# == Define: mockserver::service::Version
#
define mockserver::service::version (
  $ensure,
  $user,
  $group,
  ) {

  $version = $title

  # config service
  $shell            = '/sbin/nologin'

  $service = {
    'name'     => "mockserver@${version}",
    'file'     => "/etc/systemd/system/mockserver@${version}.service",
    'template' => 'mockserver/mockserver@.service.erb',
    'mode'     => '0644',
  }

  case $ensure {
    present: {
      $real_ensure = file
      $service_ensure = running
      $service_enable = true
    }
    default: {
      $real_ensure = absent
      $service_ensure = stopped
      $service_enable = false
    }
  }

  file { "mockserver@${version}":
    ensure  => $real_ensure,
    content => template($service['template']),
    path    => $service['file'],
    mode    => $service['mode'],
    owner   => $user,
    group   => $group,
  }

  service { "mockserver@${version}":
    ensure => $service_ensure,
    enable => $service_enable,
    notify => Class['mockserver::service']
  }
}
