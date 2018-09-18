require 'puppet/util/network_device/mikrotik'

class Puppet::Util::NetworkDevice::Mikrotik::Facts
  attr_reader :transport
  
  def initialize(transport)
    @transport = transport
  end

  def connection
    @transport.connection
  end

  def retrieve
    facts_raw = {}    
    system_resources = connection.get_reply("/system/resource/getall")    
    system_resources.each do |system_resource| 
      if system_resource.key?('!re')
        facts_raw = system_resource.reject { |k, v| ['!re', '.tag'].include? k }
      end
    end
    
    facts = {}
    facts_raw.each do |k, v|
      new_key = k.gsub(/-/, '_')
      facts[new_key] = v
    end
    
    facts.merge(get_other_facts)
  end

  def get_other_facts
    {
      'ec2_metadata' => ec2_metadata,
      'osfamily' => 'Mikrotik',
      'os' => {
        'family' => 'Mikrotik',
        'name'   => 'RouterOS'
      }
    }
  end

  def ec2_metadata
    {
      'instance-id' => ec2('instance-id'),
      'instance-type' => ec2('instance-type'),
      'local-ipv4' => ec2('local-ipv4'),
      'mac' => ec2('mac'),
      'public-ipv4' => ec2('public-ipv4'),
      'placement' => {
         'availability-zone' => ec2('placement/availability-zone'),
      },
    }
  end

  def ec2(path)
    params = {
      'url' => "http://169.254.169.254/latest/meta-data/#{path}",
      'mode' => 'http',
      'output' => 'user', 
    }
    p_array = params.map { |k,v| "=#{k}=#{v}" }
    reply = connection.get_reply('/tools/fetch',*p_array)
    if result = reply.find_sentence('data')
      result['data']
    else
      nil
    end
  end
end