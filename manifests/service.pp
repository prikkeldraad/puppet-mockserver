# == Class mockserver::service
#
# Enable the wrapper for all mockservers

class mockserver::service {

  # refresh daemon because else there might be access denied error
  exec { 'daemon-reexec':
    command => 'systemctl daemon-reexec',
    path    => '/usr/local/bin/:/bin/',
  }

  service { 'mockserver':
    ensure => running,
    enable => true,
  }

}
