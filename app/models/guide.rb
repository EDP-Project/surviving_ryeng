class Guide < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments#, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }
end
