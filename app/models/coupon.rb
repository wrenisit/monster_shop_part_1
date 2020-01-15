class Coupon <ApplicationRecord

  validates_presence_of :name, :amount, :merchant
  validates :name, presence: true, uniqueness: true, case_sensitive: false

  belongs_to :merchant

end
