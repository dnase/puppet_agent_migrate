require 'puppet'
Facter.add('ssldir') do
  setcode do
    ssldir = `puppet agent --configprint ssldir`
    ssldir.strip
  end
end
