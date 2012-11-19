# TODO: On future, we should use Sidekiq to delay jobs...
#       Today we do it with threads because we don't want
#       to use more dynos (3 F's... Free!)

class MissionCheckJob
  # include Sidekiq::Worker

  def perform(enrollment_id)
    MissionEnrollment.find(enrollment_id).check
  end

  class << self
    # def check(enrollment)
    #   perform_async enrollment.id
    # end
    # 
    # def lazy_check(enrollment)
    #   perform_in 30.minutes, enrollment.id
    # end

    def check(enrollment)
      perform enrollment.id
    end

    def lazy_check(enrollment)
      threaded_delayed_check(enrollment) if must_check?(enrollment)
    end

    protected
    def must_check?(enrollment)
      enrollment.last_checked_at.nil? || enrollment.last_checked_at < 2.hours.ago
    end

    def threaded_delayed_check(enrollment)
      Thread.new{ check enrollment }
    end
  end
end