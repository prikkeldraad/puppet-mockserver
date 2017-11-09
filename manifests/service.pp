# == Class mockserver::service
#
class mockserver::service {
  service { 'mockserver':
    ensure   => running,
    enable   => true,
  }
}
