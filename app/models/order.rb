class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, numericality: { only_integer: true, message: "must be a number" }

  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders
  belongs_to :user

  enum status: %w(pending packaged shipped cancelled)

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def cancel
    update(status: "cancelled")
    item_orders.each do |item_order|
      item_order.update(status: "unfulfilled")
      item_order.item.update(inventory: item_order.item.inventory + item_order.quantity)
    end
  end
end
