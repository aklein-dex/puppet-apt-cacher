# Class: apt_cacher::install
#
# This class install package apt-cacher.
#
# Parameters:
#
# [*package_manage*]
#   Whether this module should manage apt-cacher package.
#   Default: true
#
# [*package_name*]
#   apt-cacher package name.
#   Default: apt-cacher
#
# [*package_ensure*]
#   What state the package should be in. Valid value are:
#     present, installed, absent, purged, held, latest.
#   Default: present
#
class apt_cacher::install (
  $package_manage = $apt_cacher::params::package_manage,
  $package_name   = $apt_cacher::params::package_name,
  $package_ensure = $apt_cacher::params::package_ensure,
) {

  validate_bool($package_manage)
  validate_array($package_name)
  validate_string($package_ensure)

  if ! ($::osfamily in [ 'Debian', 'Ubuntu' ]) {
    fail ("${title}: ${::osfamily} not supported. Only Debian and Ubuntu are supported.")
  }

  if $package_manage {

    if ! ($package_ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
      fail("${title}: Ensure value '${package_ensure}' is not supported. Value must be 'present', 'installed', 'absent', 'purged', 'held' or 'latest'.")
    }

    package { $package_name:
      ensure => $package_ensure,
    }
  }
}
