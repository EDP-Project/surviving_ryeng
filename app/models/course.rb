class Course < ActiveRecord::Base
  #-- Associations
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :guides, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }

  #-- Scopes
  default_scope         -> { order("course_code ASC") }
  scope :newest,        -> { order("updated_at DESC") }
  scope :most_popular,  -> { order("likes DESC") }
  scope :search,        -> (q) do
                            where(" course_code LIKE ? OR description LIKE ? OR title LIKE ?", "%#{q}%", "%#{q}%", "%#{q}%") 
                           end

end
