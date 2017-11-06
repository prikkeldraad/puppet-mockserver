# puppet-mockserver
Puppet module for installation of MockServer

# Example
'''puppet
node 'default' {
  maven::settings { 'maven-user-settings':
    mirrors => [{
      id => "nexus",
      url => "http://central.maven.org/maven2/",
      mirrorof => "*",
    }]
  }

  class { 'mockserver':
  }
}
'''
