class User < ActiveRecord::Base

  has_one    :city
  has_one    :profile
  has_many   :mission_enrollments

  belongs_to :game_version

  devise :database_authenticatable,   :trackable,
         :recoverable, :rememberable, :confirmable,
         :validatable, :omniauthable, :registerable

  mount_uploader :avatar, UsersAvatarUploader

  attr_accessible :email,  :password,    :password_confirmation,
                  :avatar, :remember_me, :provider, :uid, :element,
                  :points, :game_version_id, :nickname, :full_name,
                  :profile, :avatar_cache

  def last_mission_enrollment
    user.mission_enrollments.order('created_at DESC').limit(1)
  end

  def current_mission_enrollment
    last_enrollment = last_mission_enrollment
    if last_enrollment.accomplished?
      last_enrollment.create_next
    else
      last_enrollment
    end
  end
end
