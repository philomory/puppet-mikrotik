require 'puppet/provider/mikrotik_api'

Puppet::Type.type(:mikrotik_interface_bridge).provide(:mikrotik_api, :parent => Puppet::Provider::Mikrotik_Api) do
  confine feature: :mtik
  
  mk_resource_methods

  def self.instances
    interfaces = Puppet::Provider::Mikrotik_Api::get_all("/interface/bridge")
    instances = interfaces.collect { |interface| interface(interface) }    
    instances
  end
  
  def self.interface(data)
      new(
        :ensure      => :present,
        :name        => data['name'],
        :mtu         => data['mtu'],
        :arp         => data['arp'],
        :arp_timeout => data['arp-timeout'],
        :admin_mac   => data['admin-mac']
      )
  end

  def flush
    Puppet.debug("Flushing Bridge #{resource[:name]}")
      
    params = {}
    params["name"] = resource[:name]
    params["mtu"] = resource[:mtu] if ! resource[:mtu].nil?
    params["arp"] = resource[:arp] if ! resource[:arp].nil?
    params["arp-timeout"] = resource[:arp_timeout] if ! resource[:arp_timeout].nil?
    params["admin-mac"] = resource[:admin_mac] if ! resource[:admin_mac].nil?

    lookup = {}
    lookup["name"] = resource[:name]
    
    Puppet.debug("Params: #{params.inspect} - Lookup: #{lookup.inspect}")

    simple_flush("/interface/bridge", params, lookup)
  end  
end