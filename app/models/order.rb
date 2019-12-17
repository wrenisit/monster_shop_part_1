class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, numericality: { only_integer: true, message: "must be a number" }

  has_many :item_orders
  has_many :items, through: :item_orders

  def grandtotal
    item_orders.sum('price * quantity')
  end
end
