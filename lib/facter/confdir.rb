require 'puppet'
Facter.add('confdir') do
  setcode do
    confdir = `puppet agent --configprint confdir`
    confdir.strip
  end
end
