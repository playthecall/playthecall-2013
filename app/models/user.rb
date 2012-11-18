class User < ActiveRecord::Base

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

end
