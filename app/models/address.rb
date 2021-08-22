class Address < ApplicationRecord
  belongs_to :customer
  
  validates :name, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
  
end
