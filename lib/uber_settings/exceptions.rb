module UberSettings
  class SettingNotFound < StandardError

  end

  class InvalidSettingName < StandardError

  end

  class InvalidSettingOptions < StandardError
    
  end

  class InvalidSettingValueType < StandardError
    
  end

  class UnknownSettingValueType < StandardError
    
  end

  class UnknownDataProvider < StandardError
    
  end
end