class MissionValidator
  attr_reader :enrollment

  def initialize(enrollment)
    @enrollment = enrollment
  end

  def mission_params
    @mission_params ||= MissionValidator::Params.new @enrollment.mission
  end

  def enrollment_params
    @enrollment_params ||= MissionValidator::Params.new @enrollment
  end

  def presenter
    @presenter ||= "#{self.class.name}Presenter".constantize.new(@enrollment, self)
  end

  def accomplished?
    raise 'Not implemented'
  end

  class Params
    def initialize(resource)
      @resource = resource
    end

    def [](key)
      resource_params[key]
    end

    def []=(key, value)
      params                      = resource_params
      params[key]                 = value
      @resource.validation_params = YAML.dump params
      value
    end

    protected
    def resource_params
      YAML.load @resource.validation_params
    end
  end
end