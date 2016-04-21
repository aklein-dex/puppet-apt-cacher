# apt_cacher

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with apt_cacher](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

The apt_cacher module installs, configures and manages the apt-cacher service.

## Setup

### What apt_cacher affects

The apt_cacher module installs apt-cacher. All the customs settings are saved in a fragment file in /etc/apt-cacher/conf.d.

### Beginning with apt_cacher

To install the package apt-cacher with the default configuration:

``` puppet
class { 'apt_cacher': }
```

## Usage

To customize your apt-cacher, you can pass parameters:
``` puppet
class { 'apt_cacher': 
  admin_email         => 'admin@example.com',
  distinct_namespaces => 1,
}
```

Or you can set custom values in hiera:
``` hiera
apt_cacher::admin_email: 'admin@example.com'
apt_cacher::distinct_namespaces: 1
``` 

## Reference

### Parameters

All the parameters for this module match the actual parameters for apt-cacher:

* group (default www-data)
* user (default www-data)
* cache_dir
* log_dir
* admin_email
* daemon_port
* daemon_addr
* offline_mode
* checksum
* concurrent_import_limit
* http_proxy
* http_proxy_auth
* use_proxy
* use_proxy_auth
* interface
* limit
* path_map
* distinct_namespaces
* allowed_hosts
* denied_hosts
* allowed_ssl_locations
* allowed_ssl_ports
* allowed_locations
* ubuntu_release_names
* generate_reports
* clear_cache
* debug
* package_files_regexp
* pdiff_files_regexp
* index_files_regexp
* installer_files_regexp
* checksum_files_regexp
* skip_checksum_files_regexp
* soap_url_regexp

Please look at man apt-cacher for examples and default values.

## Limitations

This module is only available for Debian and Ubuntu.

## Development

Open to any modifications.

