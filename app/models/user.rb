class User < ActiveRecord::Base

  ELEMENTS = ['earth', 'fire', 'air', 'water', '']

  has_one    :profile
  has_many   :mission_enrollments
  has_many   :missions, through: :game_version
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

  def self.ranking
    User.order('points DESC').limit(10)
  end
end
