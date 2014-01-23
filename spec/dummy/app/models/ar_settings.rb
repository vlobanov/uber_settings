class ArSettings < ActiveRecord::Base
  def self.set_value(name, value)
    setting = ArSettings.find_or_initialize_by(name: name.to_s)
    setting.value = Marshal.dump(value)
    setting.save!
  end

  def self.get_value(name)
    value = ArSettings.find_by(name: name.to_s).value
    Marshal.load(value)
  end
end
