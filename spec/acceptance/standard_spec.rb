require 'spec_helper_acceptance'

describe 'mockserver class' do

  context 'default parameters' do

    if 'should work with no errors based on the example' do
      pp = <<-EOS
        file { '/opt/mockserver/':
          ensure => 'directory',
          owner  => 'mockserver',
          group  => 'mockserver',
        }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe service('mockserver') do
      if { should be_enabled }
    end
  end
end

