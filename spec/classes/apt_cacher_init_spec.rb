require 'spec_helper'

describe 'apt_cacher', :type => :class do
  let(:facts) {{ :osfamily => 'Debian' }}

  context 'should compile' do
    #Puppet::Util::Log.level = :debug
    #Puppet::Util::Log.newdestination(:console)
    it { should compile }
  end

  context 'contains classes' do
    it { should contain_class('apt_cacher') }
    it { should contain_class('apt_cacher::install') }
    it { should contain_class('apt_cacher::service') }
    it { should contain_class('apt_cacher::params') }
    it { should contain_class('apt_cacher::config') }
  end

  context 'with invalid user' do
    let (:params) {{ :user => false }}
    it "should fail" do
      expect do
        catalogue
      end.to raise_error(Puppet::Error)
    end
  end

  context 'generates template with all the parameters set' do
    let :params_set do {
      :group                      => 'www-data',
      :user                       => 'www-data',
      :cache_dir                  => '/var/cache',
      :log_dir                    => '/var/log',
      :admin_email                => 'admin@email.com',
      :daemon_port                => '666',
      :daemon_addr                => 'localhost',
      :offline_mode               => '1',
      :checksum                   => '1',
      :concurrent_import_limit    => '1',
      :http_proxy                 => 'proxy.example.com',
      :http_proxy_auth            => 'proxyuser:proxypass',
      :use_proxy                  => '0',
      :use_proxy_auth             => '0',
      :interface                  => 'eth0',
      :limit                      => '0',
      :path_map                   => 'debian-changelogs',
      :distinct_namespaces        => '1',
      :allowed_hosts              => '192.168.0.20',
      :denied_hosts               => '192.168.0.10',
      :allowed_ssl_locations      => 'location',
      :allowed_ssl_ports          => '999',
      :allowed_locations          => 'ftp.example.com',
      :ubuntu_release_names       => 'dapper, nina',
      :generate_reports           => '1',
      :clean_cache                => '0',
      :debug                      => '0',
      :package_files_regexp       => 'pack-reg',
      :pdiff_files_regexp         => 'pdiff',
      :index_files_regexp         => 'index',
      :installer_files_regexp     => 'inst',
      :checksum_files_regexp      => 'check',
      :skip_checksum_files_regexp => 'skip',
      :soap_url_regexp            => 'saop',
    }
    end

    let(:params) { params_set }

    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^group = #{params_set[:group]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^user  = #{params_set[:user]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^cache_dir = #{params_set[:cache_dir]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^log_dir = #{params_set[:log_dir]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^admin_email = #{params_set[:admin_email]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^daemon_port = #{params_set[:daemon_port]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^daemon_addr = #{params_set[:daemon_addr]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^offline_mode = #{params_set[:offline_mode]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^checksum = #{params_set[:checksum]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^concurrent_import_limit = #{params_set[:concurrent_import_limit]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^http_proxy = #{params_set[:http_proxy]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^http_proxy_auth = #{params_set[:http_proxy_auth]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^use_proxy = #{params_set[:use_proxy]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^use_proxy_auth = #{params_set[:use_proxy_auth]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^interface = #{params_set[:interface]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^limit = #{params_set[:limit]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^path_map = #{params_set[:path_map]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^distinct_namespaces = #{params_set[:distinct_namespaces]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^allowed_hosts = #{params_set[:allowed_hosts]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^denied_hosts = #{params_set[:denied_hosts]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^allowed_ssl_locations = #{params_set[:allowed_ssl_locations]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^allowed_ssl_ports = #{params_set[:allowed_ssl_ports]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^allowed_locations = #{params_set[:allowed_locations]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^ubuntu_release_names = #{params_set[:ubuntu_release_names]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^generate_reports = #{params_set[:generate_reports]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^clean_cache = #{params_set[:clean_cache]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^debug = #{params_set[:debug]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^package_files_regexp = #{params_set[:package_files_regexp]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^pdiff_files_regexp = #{params_set[:pdiff_files_regexp]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^index_files_regexp = #{params_set[:index_files_regexp]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^installer_files_regexp = #{params_set[:installer_files_regexp]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^checksum_files_regexp = #{params_set[:checksum_files_regexp]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^skip_checksum_files_regexp = #{params_set[:skip_checksum_files_regexp]}$/)}
    it { is_expected.to contain_file('apt_cacher_custom_conf_file').with_content(/^soap_url_regexp = #{params_set[:soap_url_regexp]}$/)}

  end

end

