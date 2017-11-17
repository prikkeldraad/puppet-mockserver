# == Class mockserver::params
#
# This class sets default values for mockserver
#
class mockserver::params {
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
  $version     = ['3.10.8']
  $log_dir     ='/var/log/mockserver'
  $install_dir = '/opt/mockserver'
  $user        = 'mockserver'
  $group       = 'mockserver'
  $uri         = 'https://repo1.maven.org/maven2/'
}
