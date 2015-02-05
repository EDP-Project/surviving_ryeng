class User < ActiveRecord::Base
  #-- Devise user attributes --
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #-- Validations --
  VALID_USERNAME_REGEX = /\A[a-z0-9][-a-z0-9]{1,19}\z/i

  # Users must sign up with a 3-32 character username with valid format
  validates :username, presence: true, length: { minimum: 3, maximum: 32 },
            format: { with: VALID_USERNAME_REGEX }, uniqueness: { case_sensitive: false }

  before_save { self.email.downcase! }

  #-- Friendships --
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :friend_requests, dependent: :destroy
end
