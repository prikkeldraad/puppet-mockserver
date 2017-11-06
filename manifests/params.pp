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

  # Where to stick the external fact for reporting the version
  # Refer to:
  #   https://docs.puppet.com/facter/3.5/custom_facts.html#fact-locations
  #   https://github.com/puppetlabs/facter/commit/4bcd6c87cf00609f28be23f6463a3d76d0b6613c
#  if versioncmp($::facterversion, '2.4.2') >= 0 {
#    $facter_dir = '/opt/puppetlabs/facter/facts.d'
#  }
#  else {
#    $facter_dir = '/etc/puppetlabs/facter/facts.d'
#  }

  $stop_command = 'service mockserver stop && sleep 10'

  # java
  $java_home = '/opt/java'
  
  $log_dir ='/var/log/mockserver'
}
