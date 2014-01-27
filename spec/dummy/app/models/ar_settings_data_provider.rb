class ArSettingsDataProvider < ActiveRecord::Base
  include UberSettings::ActiveRecord
  self.table_name= "ar_settings"
end
