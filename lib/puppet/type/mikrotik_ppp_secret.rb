Puppet::Type.newtype(:mikrotik_ppp_secret) do
  apply_to_all

  ensurable

  newparam(:name) do
    desc 'Name of the user'
    isnamevar
  end

  newproperty(:state) do
    desc "Enabled or disabled"
    newvalues(:enabled,:disabled)
    defaultto(:enabled)
  end

  newproperty(:password) do
    desc 'User password'
  end

  newproperty(:service) do
    desc 'Specifies service that will use this user'
  end

  newproperty(:caller_id) do
    desc 'Sets IP address for PPTP, L2TP or MAC address for PPPoE'
  end

  newproperty(:profile) do
    desc 'Profile name for the user'
  end

  newproperty(:local_address) do
    desc 'Assigns an individual address to the PPP-server'
  end

  newproperty(:remote_address) do
    desc 'Assigns an individual address to the PPP-client'
  end

  newproperty(:routes, :array_matching => :all) do
    desc 'Routes that appear on the server when the client is connected'

    def insync?(is)
      if is.is_a?(Array) and @should.is_a?(Array)
        is.sort == @should.sort
      else
        is == @should
      end
    end
  end

  newproperty(:limit_bytes_in) do
    desc 'Maximum amount of bytes user can transmit'
  end

  newproperty(:limit_bytes_out) do
    desc 'Maximum amount of bytes user can receive'
  end
end
