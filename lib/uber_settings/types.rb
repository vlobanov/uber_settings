require 'uber_settings/customizable_file'

module UberSettings
  DATA_TYPES = [:string, :text, :integer, :float, :boolean, :file]

  DATA_TYPES_PREDICATES = {
    string:  -> (val) { val.is_a?(String) },
    text:    -> (val) { val.is_a?(String) },
    integer: -> (val) { val.is_a?(Integer) },
    float:   -> (val) { val.is_a?(Float) || val.is_a?(Integer) },
    boolean: -> (val) { [true, false, nil].include?(val) },
    file:    -> (val) { val.is_a?(CustomizableFile) }
  }
end