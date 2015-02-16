class Guide < ActiveRecord::Base
  #-- Associations
  belongs_to :course
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  #-- Attachment attributes
  accepts_nested_attributes_for :attachments

  #-- Validations
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 100 }
end
