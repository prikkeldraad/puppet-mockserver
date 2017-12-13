Service {
  provider => 'systemd'
}

$versions = {
  '3.10.8' => {
    ensure => present
  },
  '3.6.2' => {
    ensure => present
  }
}

class { 'mockserver':
  versions  => $versions
}
