class Enrollment < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :course

  #-- Validations
  validates :user_id, uniqueness: { scope: [:course_id] }
  validates_presence_of :user_id, :course_id

end
