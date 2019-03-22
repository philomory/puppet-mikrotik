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
