class MissionValidator
  attr_reader :enrollment

  VALIDATORS = [
    ['Facebook Likes Validator', 'FacebookSocialMissionValidator']
  ]

  def initialize(enrollment)
    @enrollment = enrollment
  end

  def mission
    @enrollment.mission
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

  # Subclasses should implement check, accomplished? and initialize_params!

  def check
    false
  end

  def accomplished?
    raise 'Not implemented'
  end

  def initialize_params
    Hash.new
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