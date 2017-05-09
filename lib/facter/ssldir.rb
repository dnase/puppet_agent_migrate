require 'puppet'
Facter.add('ssldir') do
  setcode do
    Puppet.settings['ssldir']
  end
end
