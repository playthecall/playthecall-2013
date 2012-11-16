class MissionPresenter
  attr_reader :enrollment, :validator

  def initialize(enrollment, validator)
    @enrollment, @validator = enrollment, validator
  end

  def mission_params
    validator.mission_params
  end

  def enrollment_params
    validator.enrollment_params
  end

  def html
    raise 'not done yet'
  end
end