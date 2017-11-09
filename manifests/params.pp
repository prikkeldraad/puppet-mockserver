# == Class mockserver::params
#
# This class sets default values for mockserver
#
class mockserver::params {
  case $::facts['os']['family'] {
    'Redhat': {
      $shell = '/sbin/nologin'

      case $::facts['os']['release']['major'] {
        '6' : {
          $service_file     = '/etc/init.d/mockserver'
          $service_template = 'mockserver/mockserver.init.erb'
          $service_mode     = '0755'
        }
        '7' : {
          $service_file     = '/usr/lib/systemd/system/mockserver.service'
          $service_template = 'mockserver/mockserver.service.erb'
          $service_mode     = '0644'
        }

        default: {
          fail( "$::{facts['os']['family']} $::{facts['os']['release']['major']} is not supported" )
        }
      }
    }

    default: {
      fail ( "$::{facts['os']['family']} is not supported" )
    }
  }

  $service = {
    'name'     => 'mockserver',
    'file'     => $service_file,
    'template' => $service_template,
    'mode'     => $service_mode,
  }

  $settings = {
    log_level   => 'WARN',
    server_port => 8411,
    proxy       => {
      port         => undef,
      remote_port  => undef,
      remote_host  => 'localhost',
    },
    netty => {
      lead_detection_level => 'advanced',
      event_loop_threads  => 64,
    },
    java => {
      xmx => '512m',
    },
  }

  # java
  $java_home = '/opt/java'
  
  # defaults
  $version = '3.10.8'
  $log_dir ='/var/log/mockserver'
  $dir     = '/opt/mockserver'
  $user    = 'mockserver'
  $group   = 'mockserver'
  $uri     = 'https://repo1.maven.org/maven2/'
}
