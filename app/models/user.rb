class User < ActiveRecord::Base

  ELEMENTS = ['earth', 'fire', 'air', 'water', '']

  has_one    :profile
  has_many   :mission_enrollments
  has_many   :missions, through: :chapter
  has_many   :chapters, through: :game_version
  belongs_to :city
  belongs_to :game_version

  accepts_nested_attributes_for :profile

  validates_presence_of   :city
  validates_presence_of   :game_version

  validates_format_of     :nickname, :with => /[a-z\-0-9]+$/
  validates_uniqueness_of :nickname

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

  def has_accomplished?(mission)
    mission_enrollments.any? {|m| m.mission == mission and m.accomplished }
  end

  def nickname=(value)
    self[:nickname] = value.downcase
  end

  def current_chapter
    chapters.order("position ASC").select { |c| !Chapter.finished?(c, self) }.first or
      chapters.order("position ASC").first

  end

  def current_mission
    if mission_enrollments.any?
      finished_mission_ids = mission_enrollments.where(accomplished: true).map &:mission_id
      unfinished_mission_ids = mission_enrollments.where(accomplished: false).map &:mission_id
      current_chapter.missions.where(id: unfinished_mission_ids).order("position ASC").first or
        current_chapter.missions.order("position ASC").where("id not in (#{finished_mission_ids.join(",")})").order("position ASC").first
    else
      current_chapter.missions.order("position ASC").first
    end
  end

  def current_mission_enrollment
    mission_enrollments.find_by_mission_id(current_mission.try(:id))
  end
end
