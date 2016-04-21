#
class apt_cacher::config (
  $conf_dir =  $apt_cacher::params::conf_dir
) {
  
  # Make sure the folder exists
  file { $conf_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    require => Class['apt_cacher::install'],
    notify  => Class['apt_cacher::service'],
  }
}