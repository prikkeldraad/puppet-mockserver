# == Class mockserver::config
#
# Create directories, user
#
define mockserver::config (
  $ensure,
  $version,
  $settings,
  $install_dir,
  $user,
  $group,
  $log_dir,
  $log_level,
  $server_port,
  ) {

  case $ensure {
    present: {
      $directory_ensure = directory
      $file_ensure = file
    }
    default: {
      $directory_ensure = absent
      $file_ensure = absent
    }
  }
  file { "${install_dir}/${version}":
    ensure => $directory_ensure,
  }
  file { "${install_dir}/${version}/bin":
    ensure => $directory_ensure,
  }
  file { "${install_dir}/${version}/lib":
    ensure => $directory_ensure,
  }

  file { "${install_dir}/${version}/bin/mockserver.sh":
    ensure  => $file_ensure,
    content => template('mockserver/mockserver.sh.erb'),
    owner   => $user,
    group   => $group,
    mode    => '0755',
  }

  file { "${log_dir}/mockserver_${version}.log":
    ensure => $file_ensure,
    owner  => $user,
    group  => $group,
  }
}
