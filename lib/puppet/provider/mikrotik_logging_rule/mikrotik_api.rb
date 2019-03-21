require 'puppet/provider/mikrotik_api'

Puppet::Type.type(:mikrotik_logging_rule).provide(:mikrotik_api, :parent => Puppet::Provider::Mikrotik_Api) do
  confine :feature => :mtik
  
  mk_resource_methods

  def self.instances
    rules = get_all("/system/logging")
    instances = rules.collect { |rule| loggingRule(rule) }
  end
  
  def self.loggingRule(rule)
    topics = rule['topics']
    name = topics + "_" + rule['action']


    Puppet.debug("Rule is: #{rule}")
    Puppet.debug("Topics are: #{topics}")

    obj = new(
      :ensure => :present,
      :name   => name,
      :topics => topics,
      :action => rule['action'],
      :prefix => rule['prefix'],
    )
    Puppet.debug("Resource made: #{obj.instance_variable_get(:@property_hash)}")
    obj
  end

  def flush
    if resource[:name]
      topics, action = resource[:name].split('_')
      resource[:topics] ||= topics
      resource[:action] ||= action
    end
    name = resource[:name] || resource[:topics] + "_" + resource[:action]
    Puppet.debug("Flushing Logging Rule #{name}") 
    
    params = {}
    params["topics"] = resource[:topics]
    params["action"] = resource[:action]
    params["prefix"] = resource[:prefix] unless resource[:prefix].nil?
    
    lookup = { 
      "topics" => resource[:topics],
      "action" => resource[:action]
    }
    
    Puppet.debug("Rule: #{params.inspect} - Lookup: #{lookup.inspect}")
      
    simple_flush("/system/logging", params, lookup)
  end
end
