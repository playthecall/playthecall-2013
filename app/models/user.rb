class User < ActiveRecord::Base

  ELEMENTS = ['earth', 'fire', 'air', 'water', '']

  has_one    :profile
  has_many   :mission_enrollments
  belongs_to :city
  belongs_to :game_version

  accepts_nested_attributes_for :profile

  validates_presence_of   :city
  validates_uniqueness_of :nickname
  validates_format_of     :nickname, :with => /[a-z\-0-9]+$/

  validates_inclusion_of :gender,  in: ['male', 'female']
  validates_inclusion_of :element, in: ELEMENTS

  mount_uploader :avatar, UsersAvatarUploader

  attr_accessible :city_id, :email,  :password, :password_confirmation, :avatar,
                  :avatar_cache, :remember_me, :provider, :element, :uid,
                  :points, :game_version_id, :nickname, :gender, :name,
                  :profile, :avatar_cache, :profile_attributes, :bio, :city_id

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
      last_enrollment.create_next || last_enrollment
    else
      last_enrollment
    end
  end
end
