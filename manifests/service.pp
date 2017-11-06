class mockserver::service {
  file { 'mockserver_service':
    ensure  => 'file',
    content => template($mockserver::service_template),
    path    => $mockserver::service_file,
    mode    => $mockserver::service_mode,
    owner   => $mockserver::user,
    group   => $mockserver::group
  }

  service { 'mockserver':
    ensure   => running,
    enable   => true,
  }
}
