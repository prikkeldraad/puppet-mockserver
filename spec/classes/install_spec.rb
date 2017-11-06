require 'spec_helper'

describe 'mockserver::install' do
  let(:title) {'mockserver'}
  let :pre_condition do
    "class { 'mockserver': }"
  end

  let(:facts) do
    {
      'os' => {
        'family'  => 'Redhat',
        'release' => {
          'major' => '7',
        }
      },
      'osfamily' => 'Redhat'
    }
  end

  context 'defaults' do
    describe 'user' do
      let :pre_condition do
        "class { 'mockserver': 
          user  => 'mockserver',
          group => 'mockserver',
        }"
      end

      it { is_expected.to contain_user('mockserver') }
      it { is_expected.to contain_group('mockserver') }
    end

    it { is_expected.to compile }

#    it { is_expected.to contain_service('mockserver').with(
#        :ensure  => 'running',
#        :enabled => true,
#    )}


  end
end
