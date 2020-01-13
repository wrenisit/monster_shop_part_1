class Coupon <ApplicationRecord

  validates_presence_of :name, :amount, :merchant
  belongs_to :merchant

  def valid_coupons
    where(active: true)
  end

  def disabled_coupons
    where(active: false)
  end
end
