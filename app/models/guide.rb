class Guide < ActiveRecord::Base
  #-- Associations
  belongs_to :course
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  #-- Attachment attributes
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }

  #-- Validations
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 100 }
end
