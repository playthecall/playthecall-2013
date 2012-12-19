# TODO: On future, we should use Sidekiq to delay jobs...
#       Today we do it with threads because we don't want
#       to use more dynos (3 F's... Free!)

class MissionCheckJob
  # include Sidekiq::Worker

  def perform(enrollment_id, params)
    MissionEnrollment.find(enrollment_id).check params
  end

  class << self
    # def check(enrollment)
    #   perform_async enrollment.id
    # end
    # 
    # def lazy_check(enrollment)
    #   perform_in 30.minutes, enrollment.id
    # end

    def check(enrollment, params)
      self.new.perform enrollment.id, params
    end

    def lazy_check(enrollment, params)
      threaded_delayed_check(enrollment, params) if must_check?(enrollment)
    end

    protected
    def must_check?(enrollment)
      enrollment.last_checked_at.nil? || enrollment.last_checked_at < 2.hours.ago
    end

    def threaded_delayed_check(enrollment, params)
      if Rails.env.development?
        check enrollment, params
      else
        Thread.new{ check enrollment, params }
      end
    end
  end
end