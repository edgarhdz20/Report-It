class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :reports
  mount_uploader :avatar, AvatarUploader

  validates :role, :username, presence: true

  scope :except_user, ->(user_id) { where.not(:id => user_id) }
  scope :supervisors, -> { joins(:role).where("roles.is_supervisor = ?", true) }
  scope :administrators, -> { joins(:role).where("roles.is_admin = ?", true) }
  scope :actives, -> { where(:active => true) }

  def is_admin?
  	self.role.name == "Admin"
  end

  def is_jmas?
  	self.role.name == "JMAS"
  end

  def is_municipio?
    self.role.name == "Municipio"
  end

  def is_cfe?
    self.role.name == "CFE"
  end

  def email_required?
    false
  end
end
