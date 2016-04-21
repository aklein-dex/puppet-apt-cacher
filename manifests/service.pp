# Class: apt_cacher::service
#
# This class manage apt-cacher service.
#
# Parameters:
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
#   Whether apt-cacher should be running.
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
class apt_cacher::service (
  $service_name        = $apt_cacher::params::service_name,
  $service_enable      = $apt_cacher::params::service_enable,
  $service_manage      = $apt_cacher::params::service_manage,
  $service_ensure      = $apt_cacher::params::service_ensure,
  $service_has_status  = $apt_cacher::params::service_has_status,
  $service_has_restart = $apt_cacher::params::service_has_restart,
) {

  validate_string($service_name)
  validate_string($service_ensure)
  
  validate_bool($service_enable)
  validate_bool($service_manage)
  validate_bool($service_has_status)
  validate_bool($service_has_restart)
  
  
  if $service_manage {
    
    if ! ($service_ensure in [ 'running', 'stopped' ]) {
      fail("${title}: Ensure value '${service_ensure}' is not supported. Value must be 'running' or 'stopped'.")
    }

    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => $service_has_status,
      hasrestart => $service_has_restart,
    }
  }
}
