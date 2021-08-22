class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items ,dependent: :destroy
  
  enum payment_method: {
    credit_card: 0,
    transfer: 1
  }
  
  enum status: {
    waite_payment: 0,
    confirmation: 1,
    in_making: 2,
    preparing: 3,
    shipped: 4
  }
  
end
