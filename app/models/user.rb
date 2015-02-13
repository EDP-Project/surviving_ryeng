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

  #-- Courses --
  has_many :enrollments
  has_many :courses, through: :enrollments


#Used to allow users to login via username
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end
end
