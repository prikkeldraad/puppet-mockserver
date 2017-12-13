# puppet-mockserver
Puppet module for installation of MockServer (https://github.com/jamesdbloom/mockserver)  
Running multiple times with different versions it installs multiple instances, mind to assign different ports

# Examples
NOTE: maven settings are optional. Use those when you have your own proxy for maven central.

## Single version

```puppet
$maven_url       = 'http://your_nexus_url'
$maven_id        = 'nexus'
$maven_mirror_of = '*'

maven::settings { 'maven-user-settings':
  mirrors => [{
    id       => $maven_id,
    url      => $maven_url,
    mirrorof => $maven_mirror_of
  }]
}

class { 'mockserver': }
```

## Multi version install

```puppet
$versions = {
  '3.10.8' => {
    ensure      => present,
    server_port => 8411
  },
  '3.6.2' => {
    ensure      => present,
    server_port => 8412
  }
}

$maven_url       = 'http://your_nexus_url'
$maven_id        = 'nexus'
$maven_mirror_of = '*'

maven::settings { 'maven-user-settings':
  mirrors => [{
    id       => $maven_id,
    url      => $maven_url,
    mirrorof => $maven_mirror_of
  }]
}

class { 'mockserver':
  versions  => $versions
}
```
