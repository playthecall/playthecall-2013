class User < ActiveRecord::Base

  ELEMENTS = ['earth', 'fire', 'air', 'water', '']

  has_one    :profile
  has_many   :mission_enrollments
  has_many   :missions, through: :chapter
  has_many   :chapters, through: :game_version
  belongs_to :city
  belongs_to :game_version
  belongs_to :oracle

  attr_accessor :country_id

  accepts_nested_attributes_for :profile, :oracle

  validates_presence_of   :city
  validates_presence_of   :game_version

  validates_format_of     :nickname, :with => /^[a-z_\-0-9]+$/
  validates_uniqueness_of :nickname

  validates_inclusion_of :gender,  in: ['male', 'female']
  validates_inclusion_of :element, in: ELEMENTS

  validates_presence_of :birthday
  validate :validate_birthday

  mount_uploader :avatar, UsersAvatarUploader

  attr_accessible :city_id, :email,  :password, :password_confirmation, :avatar,
                  :avatar_cache, :remember_me, :provider, :element, :uid,
                  :points, :game_version_id, :nickname, :gender, :name,
                  :profile, :avatar_cache, :profile_attributes, :bio, :city_id,
                  :oracle_attributes, :country_id, :facebook_profile, :twitter_profile,
                  :google_plus_profile, :youtube_profile, :instagram_profile, :birthday

  devise :database_authenticatable,   :trackable,
         :recoverable, :rememberable, :confirmable,
         :validatable, :omniauthable, :registerable

  def last_mission_enrollment
    mission_enrollments.order('created_at DESC').limit(1).first
  end

  def self.ranking
    User.where('points > ?', 0).order('points DESC').limit(10)
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
      finished_mission_ids   = mission_enrollments.where(accomplished: true).pluck :mission_id
      unfinished_mission_ids = mission_enrollments.where(accomplished: false).pluck :mission_id
      current_chapter.missions.where(id: unfinished_mission_ids).order("position ASC").first or
        current_chapter.missions.where("id not in (#{finished_mission_ids.join(",")})").order("position ASC").first
    else
      current_chapter.missions.order("position ASC").first
    end
  end

  def current_mission_enrollment
    mission_enrollments.find_by_mission_id(current_mission.try(:id))
  end

  # If current user is OK with all mission enrollments
  def accomplished_all_enrolled_missions?
    mission_enrollments.select{|m| !m.accomplished? }.empty?
  end

  # Returns the last +MissionEnrollment+
  def last_accomplished_mission_enrollment
    mission_enrollments.accomplished.last
  end

  def current_or_last_accomplished_mission_enrollment
    return last_accomplished_mission_enrollment if accomplished_all_enrolled_missions?
    current_mission_enrollment
  end

  def aggregate_points!
    update_attribute(:points, aggregate_points)
  end

  def aggregate_points
    mission_enrollments.map{|me| me.validator.enrollment_params[:likes]}.
                        reduce(0, :+)
  end

  # If user can enroll the next mission
  def can_enroll?(mission)
    (mission_enrollments.empty? && (mission == current_chapter.missions.first_mission)) ||
    ( (current_or_last_accomplished_mission_enrollment && current_or_last_accomplished_mission_enrollment.accomplished?) &&
    (last_accomplished_mission_enrollment.mission.next_mission == mission ) )
  end

  private

  def validate_birthday
    if read_attribute(:birthday) > 13.years.ago.to_date
      errors.add :birthday, I18n.t('activerecord.user.invalid_birthday_message')
    end
  end
end
