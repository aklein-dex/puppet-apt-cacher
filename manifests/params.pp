# Class: apt_cacher::params
#
# This class set default values for parameters used in module apt_cacher
#
#
class apt_cacher::params {
  $package_ensure      = 'present'
  $package_name        = [ 'apt-cacher' ]
  $package_manage      = true
  $service_name        = 'apt-cacher'
  $service_enable      = true
  $service_ensure      = 'running'
  $service_manage      = true
  $service_has_status  = true
  $service_has_restart = true
  $install_dir         = '/etc/apt-cacher/'
  $conf_dir            = '/etc/apt-cacher/conf.d/'
  $custom_conf_file    = 'puppet-apt-cacher.conf'
  $group               = 'www-data'
  $user                = 'www-data'
}