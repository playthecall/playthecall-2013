require 'yaml'
# Represents the Validation Params from Mission Enrollment
# that is usually stored as dumped YAML
# TODO: Replace MissionValidator::Params with
class ValidationParams < String
  def to_hash
    YAML.load(self) || Hash.new
  end
end
