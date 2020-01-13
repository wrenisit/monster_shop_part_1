class Coupon <ApplicationRecord

  validates_presence_of :name, :amount, :merchant
  belongs_to :merchant

end
