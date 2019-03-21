Puppet::Type.newtype(:mikrotik_logging_rule) do
  apply_to_all

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name) do
    desc "Dummy parameter, doesn't do anything"
  end

  newproperty(:topics) do
    desc 'A comma-separated list of topics that will be filtered by this rule.'
    isnamevar

    munge do |topics|
      topics.split(',').sort.join(',')
    end

    def insync?(is)
      test_is = is.split(',')
      test_should = (@should.kind_of?(Array) ? @should[0] : @should).split(',')
      result = (test_is.sort == test_should.sort)
      Puppet.debug("Comparing #{test_is.sort.inspect} to #{test_should.sort.inspect}: #{result}")
      result
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
