require 'spec_helper'

describe 'apt_cacher::install', :type => :class do

  context 'should compile' do
    let(:facts) {{ :osfamily => 'Debian' }}
    let :params do
      { :package_ensure => 'present',
        :package_name   => [ 'apt_cacher' ],
        :package_manage => true
      }
    end
    it { should compile }
    it { is_expected.to contain_package('apt_cacher').with_ensure('present') }
  end  
  
  context 'does not manage package' do
    let(:facts) {{ :osfamily => 'Debian' }}
    let :params do
      { :package_ensure => 'present',
        :package_name   => [ 'apt_cacher' ],
        :package_manage => false
      }
    end
    it { is_expected.not_to contain_package('apt_cacher') }
  end

  context 'does not install package because unsupported OS' do
    let(:facts) {{ :osfamily => 'Something' }}
    let :params do
      { :package_ensure => 'present',
        :package_name   => [ 'apt_cacher' ],
        :package_manage => true
      }
    end
    it 'should fail' do
      expect { catalogue }.to raise_error(Puppet::Error, /Something not supported/)
    end
  end

  context 'with wrong value for ensure' do
    let(:facts) {{ :osfamily => 'Ubuntu' }}
    let :params do
      { :package_ensure => 'wrong-ensure',
        :package_name   => [ 'apt_cacher' ],
        :package_manage => true
      }
    end
    it 'should fail' do
      expect { catalogue }.to raise_error(Puppet::Error, /'wrong-ensure' is not supported/)
    end
  end
end

