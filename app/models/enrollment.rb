class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  #A user can only enroll into a given course once
  validates :user_id, uniqueness: { scope: [:course_id] }
end
