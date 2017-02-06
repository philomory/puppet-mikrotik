Puppet::Type.newtype(:mikrotik_interface_eoip) do
  apply_to_device

  ensurable do
    defaultvalues
    defaultto :present
  end
  #TODO disabled -- Defines whether item is ignored or used

  newparam(:name) do
    desc 'The EoIP tunnel name'
    isnamevar
  end

  newproperty(:mtu) do
    desc 'Maximum Transmit Unit'
  end

  newproperty(:admin_mac) do
    desc 'The MAC address for this side of the tunnel'
  end  
  
  newproperty(:arp) do
    desc 'Address Resolution Protocol to use'
    newvalues('enabled', 'disabled', 'proxy-arp', 'reply-only')
  end

  newproperty(:arp_timeout) do
    desc 'Address Resolution Protocol Timeout'
  end
  
  newproperty(:local_address) do
    desc 'IP Address for this side of the tunnel'
  end
  
  newproperty(:remote_address) do
    desc 'IP Address for the remote side of the tunnel'
  end
  
  newproperty(:tunnel_id) do
    desc 'Unique ID for this tunnel'
  end
  
  newproperty(:ipsec_secret) do
    desc 'Shared secret if IPSEC encryption is being used'
  end
  
  newproperty(:keepalive) do
    desc 'Time to keep the tunnel alive if no traffic is seen'
  end

  newproperty(:dscp) do
    desc 'The DSCP value (QoS)'
  end

  newproperty(:dont_fragment) do
    desc 'Whether to allow packet fragmentation in the tunnel'
    newvalues('inherit', 'no')
  end

  newproperty(:clamp_tcp_mss) do
    desc 'Whether to clamp the TCP MSS (?)'
    newvalues(false, true)
    defaultto true
  end

  newproperty(:allow_fast_path) do
    desc 'Whether to allow Fast Path Routing'
    newvalues(false, true)
    defaultto true
  end

  # Not frequently used settings:
  ## loop-protect -- 
  ## loop-protect-disable-time -- 
  ## loop-protect-send-interval -- 
end
