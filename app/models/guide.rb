class Guide < ActiveRecord::Base
  #-- Associations
  belongs_to :course
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  #-- Attachment attributes
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }


  #-- Scopes (mainly used for searching/sorting)
  scope :newest,          -> { order("updated_at DESC") }
  scope :approved,        -> { where(approved: true) }
  scope :most_popular,    -> { order("likes DESC") }
  scope :search,          -> (q) do
                              where("title LIKE ? OR content LIKE ?", "%#{q}%", "%#{q}%") 
                             end
  #-- Validations
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 100 }
end
