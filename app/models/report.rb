class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :report_type
  mount_uploader :avatar, AvatarUploader

  validates :report_type, :avatar, :pos_x, :pos_y, :address, :description, presence: true
end
