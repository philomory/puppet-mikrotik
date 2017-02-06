Puppet::Type.newtype(:mikrotik_ip_route) do
  apply_to_device

  ensurable do
    defaultvalues
    defaultto :present
  end
  #TODO disabled -- Defines whether item is ignored or used
  
  newparam(:name) do
    desc 'Route description'
    isnamevar
  end

  newproperty(:dst_address) do
    desc 'Destination address'
  end
  
  newproperty(:gateway) do
    desc 'Gateway address'
  end

  newproperty(:check_gateway) do
    desc 'Whether to check nexthop with ARP or Ping request.'
    newvalues(:arp, :ping)
  end

  newproperty(:type) do
    desc 'Route type'
    newvalues('unicast', 'blackhole', 'prohibit', 'unreachable')
  end

  newproperty(:distance) do
    desc 'Administrative distance of the route'
  end

  newproperty(:scope) do
    desc 'Route Scope'
  end

  newproperty(:target_scope) do
    desc 'Target Route Scope'
  end

  newproperty(:routing_mark) do
    desc 'Routing table this route belong in'
  end

  newproperty(:pref_src) do
    desc 'Preferred Source for the route'
  end

  newproperty(:bgp_as_path) do
    desc 'AS Path for BGP (advertisement ?)'
  end

  newproperty(:bgp_local_pref) do
    desc 'Local Preference for BGP (advertisement ?)'
  end

  newproperty(:bgp_prepend) do
    desc 'Prepend for BGP (advertisement ?)'
  end

  newproperty(:bgp_med) do
    desc 'MED for BGP (advertisement ?)'
  end

  newproperty(:bgp_atomic_aggregate) do
    desc 'Atomic Aggregate for BGP (advertisement ?)'
  end

  newproperty(:bgp_origin) do
    desc 'Origin for BGP (advertisement ?)'
  end

  newproperty(:route_tag) do
    desc 'Route Tag (?)'
  end

  newproperty(:bgp_communities) do
    desc 'BGP Communities for BGP (advertisement ?)'
  end
  
  # Not in Winbox:
    # vrf_interface
end
