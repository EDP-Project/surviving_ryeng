class Guide < ActiveRecord::Base
  #-- Associations
  belongs_to :course
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  #-- Attachment attributes
  accepts_nested_attributes_for :attachments

  #-- Validations
  validates :title, presence: true, length: { minimum: 5 }, message: 'Please provide a meaningful title of at least 5 characters'
  validates :content, presence: true, length: { minimum: 100 }, message: 'Your guide is not long enough.'
end
