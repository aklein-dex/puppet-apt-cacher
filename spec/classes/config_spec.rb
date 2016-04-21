require 'spec_helper'

describe 'apt_cacher::config', :type => :class do

  context 'with folder' do
    let (:params) {{ :conf_dir => '/etc/apt-cacher/conf.d' }}
    
    #it { should compile.with_all_deps } #not working
    it { is_expected.to contain_file('/etc/apt-cacher/conf.d').with_ensure('directory') }
  end  
end 
