# Class: apt_cacher
#
# This class installs and manages apt-cacher.
#
# Parameters:
#
# [*package_manage*]
#   Whether this module should manage apt-cacher package.
#   Default: true
#
# [*package_name*]
#   Apt-cacher package name.
#   Default: apt-cacher
#
# [*package_ensure*]
#   What state the package should be in. Valid value are:
#     present, installed, absent, purged, held, latest
#   Default: present
#
# [*service_manage*]
#   Whether this module should manage apt-cacher service.
#   Default: true
#
# [*service_name*]
#   apt-cacher service name.
#   Default: apt-cacher
#
# [*service_ensure*]
#   Whether apt-acher should be running.
#   Default: running
#
# [*service_enable*]
#   Whether apt-cacher service should be enabled to start at boot.
#   Default: true
#
# [*service_has_status*]
#   Whether apt-cacher’s init script has a functional status command.
#   Default: true
#
# [*service_has_restart*]
#   Whether apt-cacher’s init script has a restart command.
#   Default: true
#
# [*install_dir*]
#   Where apt-cacher is installed.
#   Default: '/etc/apt-cacher'
#
# [*conf_dir*]
#   Where custom conf file is saved.
#   Default: '/etc/apt-cacher/conf.d'
#
# [*custom_conf_file*]
#   Filename for custom conf.
#   Default: puppet-apt-cacher.conf
#
### Below are specific parameters for apt-cacher. ###
### Please see man apt-cacher for descriptions.   ###
#
# [*group*]
#   Default: www-data
#
# [*user*]
#   Default: www-data
#
# [*cache_dir*]
#
# [*log_dir*]
#
# [*admin_email*]
#
# [*daemon_port*]
#
# [*daemon_addr*]
#
# [*offline_mode*]
#
# [*checksum*]
#
# [*concurrent_import_limit*]
#
# [*http_proxy*]
#
# [*http_proxy_auth*]
#
# [*use_proxy*]
#
# [*use_proxy_auth*]
#
# [*interface*]
#
# [*limit*]
#
# [*path_map*]
#
# [*distinct_namespaces*]
#
# [*allowed_hosts*]
#
# [*denied_hosts*]
#
# [*allowed_ssl_locations*]
#
# [*allowed_ssl_ports*]
#
# [*allowed_locations*]
#
# [*ubuntu_release_names*]
#
# [*generate_reports*]
#
# [*clean_cache*]
#
# [*debug*]
#
# [*package_files_regexp*]
#
# [*pdiff_files_regexp*]
#
# [*index_files_regexp*]
#
# [*installer_files_regexp*]
#
# [*checksum_files_regexp*]
#
# [*skip_checksum_files_regexp*]
#
# [*soap_url_regexp*]
#
# Actions:
#   - Install apt-cacher
#   - Manage apt-cacher service
#
# Sample Usage:
#   class { 'apt_cacher': }
#
class apt_cacher (
  $package_manage             = $apt_cacher::params::package_manage,
  $package_name               = $apt_cacher::params::package_name,
  $package_ensure             = $apt_cacher::params::package_ensure,
  $service_manage             = $apt_cacher::params::service_manage,
  $service_name               = $apt_cacher::params::service_name,
  $service_ensure             = $apt_cacher::params::service_ensure,
  $service_enable             = $apt_cacher::params::service_enable,
  $service_has_status         = $apt_cacher::params::service_has_status,
  $service_has_restart        = $apt_cacher::params::service_has_restart,
  $install_dir                = $apt_cacher::params::install_dir,
  $conf_dir                   = $apt_cacher::params::conf_dir,
  $custom_conf_file           = $apt_cacher::params::custom_conf_file,
  
  $group                      = $apt_cacher::params::group,
  $user                       = $apt_cacher::params::user,
  $cache_dir                  = undef,
  $log_dir                    = undef,
  $admin_email                = undef,
  $daemon_port                = undef,
  $daemon_addr                = undef,
  $offline_mode               = undef,
  $checksum                   = undef,
  $concurrent_import_limit    = undef,
  $http_proxy                 = undef,
  $http_proxy_auth            = undef,
  $use_proxy                  = undef,
  $use_proxy_auth             = undef,
  $interface                  = undef,
  $limit                      = undef,
  $path_map                   = undef,
  $distinct_namespaces        = undef,
  $allowed_hosts              = undef,
  $denied_hosts               = undef,
  $allowed_ssl_locations      = undef,
  $allowed_ssl_ports          = undef,
  $allowed_locations          = undef,
  $ubuntu_release_names       = undef,
  $generate_reports           = undef,
  $clean_cache                = undef,
  $debug                      = undef,
  $package_files_regexp       = undef,
  $pdiff_files_regexp         = undef,
  $index_files_regexp         = undef,
  $installer_files_regexp     = undef,
  $checksum_files_regexp      = undef,
  $skip_checksum_files_regexp = undef,
  $soap_url_regexp            = undef,
) inherits apt_cacher::params {
  
  validate_string($group)
  validate_string($user)
  
  
  anchor { 'apt_cacher::begin': } ->
  class  { '::apt_cacher::install':
    package_manage => $package_manage,
    package_name   => $package_name,
    package_ensure => $package_ensure,
  } ->
  class  { '::apt_cacher::config':
    conf_dir => $conf_dir,
  } ->
  class  { '::apt_cacher::service':
    service_manage      => $service_manage,
    service_name        => $service_name,
    service_ensure      => $service_ensure,
    service_enable      => $service_enable,
    service_has_status  => $service_has_status,
    service_has_restart => $service_has_restart,
  } ->
  anchor { 'apt_cacher::end': }
  
  file { 'apt_cacher_custom_conf_file':
    ensure  => present,
    path    => "${conf_dir}/${custom_conf_file}",
    content => template('apt_cacher/puppet-apt-cacher.conf.erb'),
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    notify  => Service[$service_name],
  }
}
