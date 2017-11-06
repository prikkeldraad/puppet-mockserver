# Some space for comments
class mockserver (
    $version = '3.10.8',
    $dir     = '/opt/mockserver',
    $user    = 'mockserver',
    $group   = 'mockserver',
    $service = 'mockserver',
) inherits mockserver::params {
    class { 'mockserver::install': }
    class { 'mockserver::config': }
    class { 'mockserver::service': }
}
