# == Define: mockserver::service::Version
#
define mockserver::service::version (
  $user,
  $group,
  ) {

  $version = $title

  # config service
  $shell            = '/sbin/nologin'
  $service_file     = "/etc/systemd/system/mockserver@${version}.service"
  $service_template = 'mockserver/mockserver@.service.erb'
  $service_mode     = '0644'

  $service = {
    'name'     => "mockserver@${version}",
    'file'     => $service_file,
    'template' => $service_template,
    'mode'     => $service_mode,
  }

  file { "mockserver@${version}":
    ensure  => file,
    content => template($service['template']),
    path    => $service['file'],
    mode    => $service['mode'],
    owner   => $user,
    group   => $group,
  }

  service { "mockserver@${version}":
    ensure => running,
    enable => true,
    notify => Class['mockserver::service']
  }
}
