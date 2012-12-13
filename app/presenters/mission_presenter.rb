class MissionPresenter
  attr_reader :view, :enrollment, :validator

  def initialize(enrollment, validator, view)
    @enrollment, @validator, @view = enrollment, validator, view
  end

  def mission
    enrollment.mission
  end

  def mission_params
    validator.mission_params
  end

  def enrollment_params
    validator.enrollment_params
  end

  def mission_html
    raise 'not done yet'
  end

  def enrollment_html
    raise 'not done yet'
  end
end