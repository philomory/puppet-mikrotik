require 'puppet/provider/mikrotik_api'

Puppet::Type.type(:mikrotik_ospf_area_range).provide(:mikrotik_api, :parent => Puppet::Provider::Mikrotik_Api) do
  confine :feature => :mtik
  
  mk_resource_methods

  def self.instances    
    ospf_area_ranges = Puppet::Provider::Mikrotik_Api::get_all("/routing/ospf/area/range")
    instances = ospf_area_ranges.collect { |ospf_area_range| ospfAreaRange(ospf_area_range) }    
    instances
  end
  
  def self.ospfAreaRange(data)
      new(
        :ensure    => :present,
        :range     => data['range'],
        :area      => data['area'],
        :cost      => data['cost'],
        :advertise => data['advertise'] == 'yes' ? true : false,
        :comment   => data['comment']
      )
  end

  def flush
    Puppet.debug("Flushing OSPF Area Range #{resource[:range]}/#{resource[:area]}")
      
    params = {}
    params["range"]     = resource[:range]
    params["area"]      = resource[:area]
    params["cost"]      = resource[:cost]
    params["advertise"] = resource[:advertise] ? 'yes' : 'no'
    params["comment"]   = resource[:comment] if ! resource[:comment].nil?

    lookup = {
      "range" => resource[:range],
      "area"  => resource[:area]
    }
    
    Puppet.debug("Params: #{params.inspect} - Lookup: #{lookup.inspect}")

    simple_flush("/routing/ospf/area/range", params, lookup)
  end  
end
