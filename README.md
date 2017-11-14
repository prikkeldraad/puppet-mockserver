# puppet-mockserver
Puppet module for installation of MockServer (https://github.com/jamesdbloom/mockserver)
Running multiple times with different versions it installs multiple instances, mind to assign different ports

Example of site.pp with single installation of MockServer
# Example
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

Multi install
# Example
    node 'default' {
      maven::settings { 'maven-user-settings':
        mirrors => [{
          id => "nexus",
          url => "http://central.maven.org/maven2/",
          mirrorof => "*",
        }]
      }

      class { 'mockserver':
        log_level   => 'WARN',
        server_port => 8413,
        version     => '3.11',
      }
    }
