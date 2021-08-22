class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum making_status: {
    impossible_making: 0,
    waite_making: 1,
    in_making: 2,
    complete: 3
  }
  
  def subtotal
    self.price * amount
  end
  
end
