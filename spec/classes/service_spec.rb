require 'spec_helper'

describe 'apt_cacher::service', :type => :class do

  context 'should compile' do
    let :params do
      { :service_ensure => 'running',
        :service_name => 'apt-cacher',
        :service_manage => true,
        :service_enable => true,
        :service_has_status => true,
        :service_has_restart => false,
      }
    end
    it { should compile }
    it { is_expected.to contain_service('apt-cacher').with(
      'ensure'     => 'running',
      'enable'     => true,
      'hasstatus'  => true,
      'hasrestart' => false,
    ) }
  end  
  
  context 'does not manage the service' do
    let :params do
      { :service_ensure      => 'running',
        :service_name        => 'apt-cacher',
        :service_manage      => false,
        :service_enable      => true,
        :service_has_status  => true,
        :service_has_restart => false,
      }
    end
    it { is_expected.not_to contain_service('apt-cacher') }
  end  

  context 'with wrong ensure value' do
    let :params do
      { :service_ensure      => 'invalid',
        :service_name        => 'apt-cacher',
        :service_manage      => true,
        :service_enable      => true,
        :service_has_status  => true,
        :service_has_restart => false,
      }
    end
    it 'should fail' do
      expect { catalogue }.to raise_error(Puppet::Error, /'invalid' is not supported/)
    end
  end  

end
