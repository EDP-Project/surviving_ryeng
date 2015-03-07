class Enrollment < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :course

  #-- Validations
  validates :user_id, uniqueness: { scope: [:course_id] }
  validates_presence_of :user_id, :course_id

  #-- Scopes
  scope :newest,        -> { order("updated_at DESC") }
  scope :alphabetical,  -> { joins(:course).order("course_code ASC") }
  scope :search,        -> (q) { joins(:course).where("course_code LIKE ?", "%#{q}%") }

end
