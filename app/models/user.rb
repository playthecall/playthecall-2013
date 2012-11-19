class User < ActiveRecord::Base

  has_one    :city
  has_one    :profile
  has_many   :mission_enrollments
  belongs_to :game_version

  accepts_nested_attributes_for :profile

  validates_uniqueness_of :nickname
  validates_format_of     :nickname, :with => /[a-z\-0-9]+$/

  validates_inclusion_of :sex, in: [:male, :female]

  mount_uploader :avatar, UsersAvatarUploader

  attr_accessible :email,  :password,        :password_confirmation,
                  :avatar, :remember_me,     :provider, :element,   :uid,
                  :points, :game_version_id, :nickname, :full_name, :sex,
                  :profile, :avatar_cache, :profile_attributes

  devise :database_authenticatable,   :trackable,
         :recoverable, :rememberable, :confirmable,
         :validatable, :omniauthable, :registerable

  def last_mission_enrollment
    mission_enrollments.order('created_at DESC').limit(1).first
  end

  def current_mission_enrollment
    last_enrollment = last_mission_enrollment
    return MissionEnrollment.first_for(self) unless last_enrollment

    if last_enrollment.accomplished?
      last_enrollment.create_next
    else
      last_enrollment
    end
  end
end
