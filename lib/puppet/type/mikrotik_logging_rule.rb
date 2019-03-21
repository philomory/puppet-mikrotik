Puppet::Type.newtype(:mikrotik_logging_rule) do
  apply_to_all

  ensurable do
    defaultvalues
    defaultto :present
  end
  
  newproperty(:topics, :array_matching => :all) do
    desc 'The topics that will be filtered by this rule.'
    isnamevar

    munge do |topics|
      case topics
      when String
        topics.split(',')
      when Array
        topics
      end
    end

    def insync?(is)
      if is.is_a?(Array) and @should.is_a?(Array)
        is.sort == @should.sort   
      else
        is == @should
      end
    end    
  end
  
  newproperty(:action) do
    desc 'The action that the logs will be sent to.'
    isnamevar
  end
  
  newproperty(:prefix) do
    desc 'Prefix the logs by this string.'
  end

  def title_patterns
    [
      [
        /([!a-zA-Z0-9,-]+)_(\w+)/,
        [
          [:topics],
          [:action]
        ]
      ]
    ]
  end
end
