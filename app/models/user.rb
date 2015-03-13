class User < ActiveRecord::Base
  #-- Devise user attributes --
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #-- Validations --
  VALID_USERNAME_REGEX = /\A(?=.{3,32}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])\z/

  # Users must sign up with a 3-32 character username with valid format
  validates :username, presence: true, length: { minimum: 3, maximum: 32 },
            format: { with: VALID_USERNAME_REGEX }, uniqueness: { case_sensitive: false }

  before_save { self.email.downcase! }

  #-- Scopes
  scope :newest,       -> { order("created_at DESC") }
  scope :most_popular, -> { order("likes DESC") }
  scope :search,       -> (q) do
                                where("about_me LIKE ? OR username LIKE ?", "%#{q}%", "%#{q}%") 
                              end
  
  #Mailboxer requirement
  acts_as_messageable

  #-- Friendships --
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :friend_requests, dependent: :destroy

  #-- Courses --
  has_many :enrollments
  has_many :courses, through: :enrollments

  #-- Guides --
  has_many :guides

  #-- Likes --
  has_many :likes, foreign_key: "liker_id"

  #-- File attachments --
  has_many :attachments
  has_many :liked_attachments, class_name: "Attachment"

  #-- Reports --
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :reports_sent, class_name: "Report", foreign_key: "reporter_id"

#Mailboxer name
  def name
    username
  end

  def mailboxer_email
    email
  end

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
