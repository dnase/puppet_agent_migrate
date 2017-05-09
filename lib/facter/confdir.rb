require 'puppet'
Facter.add('confdir') do
  setcode do
    Puppet.settings['confdir']
  end
end
