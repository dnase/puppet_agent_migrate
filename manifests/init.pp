# Class: puppet_agent_migrate
# ===========================
#
# This class is designed to migrate and upgrade Puppet agents. 
#
# Parameters
# ----------
#
# * `new_master`
# Required - hostname of new Puppet master to which to cut over. 
#
# * `new_ca`
# Optional - new certificate authority at which to point Puppet agent
#
# * `version`
# Optional - version of Puppet agent to which to upgrade. Defaults to 'present'.
#
# * `flush_certs`
# Optional - whether or not to clear out SSL certificates. Defaults to false.
#
# Examples
# --------
#
# @example
#    class { 'puppet_agent_migrate':
#      new_master => 'newmaster.mydomain.com', 
#    }
#
# Authors
# -------
#
# Drew Nase <drew@puppet.com>
#
# Copyright
# ---------
#
# Copyright 2017 Drew Nase 
#
class puppet_agent_migrate (
  $new_master,
  $new_ca = undef,
  $version = 'present',
  $flush_certs = false,
) {
  Ini_setting {
    path    => "${::confdir}/puppet.conf",
    section => 'main',
    require => Class['::puppet_agent'],
    notify  => Service['pe-puppet'],
  }
  if !defined(Service['pe-puppet']) {
    service { 'pe-puppet': }
  }
  class { '::puppet_agent':
    package_version => $version,
  }
  ini_setting { 'puppetserver':
    ensure  => present,
    setting => 'server',
    value   => $new_master,
  }
  if $new_ca {
    ini_setting { 'puppetca':
      ensure  => present,
      setting => 'ca_server',
      value   => $new_ca,
    }
  }
  if $flush_certs {
    file { $::ssldir:
      ensure  => absent,
      force   => true,
      require => Ini_setting['puppetserver'],
      notify  => Service['pe-puppet'],
    }
  }
}
