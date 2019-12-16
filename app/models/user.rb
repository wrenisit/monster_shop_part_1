class User <ApplicationRecord
  validates_presence_of :name, presence: true
  validates_presence_of :address, presence: true
  validates_presence_of :city, presence: true
  validates_presence_of :state, presence: true
  validates_presence_of :zip, presence: true
  validates :email, uniqueness: true, case_sensitive: false, presence: true
  validates_presence_of :password, require: true
  validates_confirmation_of :password

  has_secure_password
end
