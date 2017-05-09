require 'puppet'
# credit to LMacchi
Facter.add(:agent_settings) do
  setcode do
    agent_settings = {}

    # Select all values to display
    # config: Path to puppet.conf
    # confdir: Path to configuration directory
    # ssldir: Path to your SSL directory
    keys = ['config', 'confdir', 'ssldir']

    keys.each { |k| agent_settings[k] = Puppet.settings[k] }
    agent_settings
  end
end
