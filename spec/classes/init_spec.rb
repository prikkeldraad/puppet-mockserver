require 'spec_helper'

describe 'mockserver' do
  context 'unsupported os' do
    let(:facts) do
      { 
        'os' => {
          'family' => 'Windows'
        }
      }
    end
    it { expect { catalogue }.to raise_error(Puppet::Error, /not supported/) }
  end

#  context 'with default parameters' do
#    it { should contain_class('mockserver') }
#  end
end

